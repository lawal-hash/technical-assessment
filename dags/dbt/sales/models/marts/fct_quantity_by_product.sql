select
    rank_quantity as rank,
    product_name,
    quantities_sold
from
    {{ref('int_orders_by_product')}}
where
    rank_quantity <= 5
order by
    rank_quantity asc