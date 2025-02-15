select
    rank_revenue_generated as rank,
    customer_age,
    revenue_generated
from
    {{ref('int_orders_by_age')}}
where
    rank_revenue_generated <= 5
order by
    rank_revenue_generated asc