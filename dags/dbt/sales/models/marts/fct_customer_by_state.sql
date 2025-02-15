with percentage_customer as (
select
    state,
    percentage__customer,
    rank() over(
    order by percentage__customer desc) as state_rank
from
    {{ref('int_customers_by_state')}})
	
select
    state,
    percentage__customer
from
    percentage_customer
where
    state_rank <= 3