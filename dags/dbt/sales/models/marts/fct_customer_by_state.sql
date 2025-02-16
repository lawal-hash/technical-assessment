with percentage_customer as (
select
    state_name,
    percentage__customer,
    rank() over(
    order by percentage__customer desc) as state_rank
from
    {{ref('int_customers_by_state')}})
	
select
    state_name,
    percentage__customer
from
    percentage_customer
where
    state_rank <= 3