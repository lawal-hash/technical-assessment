with transactions as (
select
	
    c.customer_age, 
    sum(st.product_quantity) as quantities_bought,
    sum(st.product_quantity * p.product_price) as revenue_generated
from
    {{ref('stg_transactions')}} st
join {{ref('stg_products')}} p 
on
    st.product_id = p.product_id
    and st.order_date between p.effective_start_date and p.effective_end_date
join {{ref('stg_customers')}} c 
on
    st.customer_id = c.customer_id
group by
    c.customer_age
    ),
transaction_rank as (
select
    customer_age, 
    quantities_bought,
    revenue_generated,
    rank() over(
order by
    quantities_bought desc) as rank_quantity_bought,
    rank() over(
order by
    revenue_generated desc) as rank_revenue_generated
from
    transactions)

select
    customer_age,
    quantities_bought,
    round(cast(revenue_generated as numeric),2) as revenue_generated,
    rank_quantity_bought,
    rank_revenue_generated
from
    transaction_rank