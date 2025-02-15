
select
    rank_quantity_bought as rank,
    customer_age,
    quantities_bought
from
    {{ref('int_orders_by_age')}}
where
    rank_quantity_bought <= 5
order by
    rank_quantity_bought asc