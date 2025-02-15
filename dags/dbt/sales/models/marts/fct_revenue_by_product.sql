
select
    rank_sales_revenue as rank,
    product_name,
    sales_revenue
from
    {{ref('int_orders_by_product')}}
where
    rank_sales_revenue <= 5
order by
    rank_sales_revenue asc