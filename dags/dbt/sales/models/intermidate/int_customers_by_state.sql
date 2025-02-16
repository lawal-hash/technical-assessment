with customer_count_per_state as (
select
    s.state,
    count(1) as customer_count
from
    {{ref('stg_customers')}} c
join {{ref('states')}} s
on
    c.state_code = s.abbreviation
group by
    s.state), prct_customer_per_state as (


select
    state as state_name,
    customer_count /(sum(customer_count) over()) as percentage_customer_per_state
from
    customer_count_per_state)

select state_name, round(percentage_customer_per_state* 100, 2) as percentage__customer
from prct_customer_per_state
