with customer_count_per_state as (
select
    state_code,
    count(1) as customer_count
from
    {{ref('stg_customers')}} c

group by
    state_code), prct_customer_per_state as (


select
    s.state as state_name,
    customer_count /(sum(customer_count) over()) as percentage_customer_per_state
from
    customer_count_per_state cs
join {{ref('us_states')}} s
on
    cs.state_code = s.abbreviation)

select state_name, round(percentage_customer_per_state* 100, 2) as percentage__customer
from prct_customer_per_state
