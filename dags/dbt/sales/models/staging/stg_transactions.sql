
with raw_transactions as ( 
    select  order_id,
    product_id,
    cust_id as customer_id,
    product_quantity,
    order_date
    from  {{source('sales', 'transactions')}}
    )
select * from raw_transactions