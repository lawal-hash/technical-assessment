with transactions as (
select
    st.product_id,
    p.product_name,
    sum(st.product_quantity) as quantities_sold,
    sum(st.product_quantity * p.product_price) as sales_revenue
from
    {{ref('stg_transactions')}} st
join {{ref('stg_products')}} p 
on
    st.product_id = p.product_id
    and st.order_date between p.effective_start_date and p.effective_end_date
group by
    st.product_id,
    p.product_name),
transaction_rank as (
select
    product_id,
    product_name,
    quantities_sold,
    round(CAST(sales_revenue AS numeric),2) as sales_revenue,
    rank() over(
    order by quantities_sold desc) as rank_quantity,
    rank() over(
    order by sales_revenue desc) as rank_sales_revenue
from
    transactions)

select
    product_name,
    quantities_sold,
    sales_revenue,
    rank_quantity,
    rank_sales_revenue
from
    transaction_rank