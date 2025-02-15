with raw_products as ( 
    select product_id,
    product_name,
    product_price,
    effective_start_date,
    effective_end_date,
    current_ind as current_indicator
    from  {{source('sales', 'products')}}
    )
select * from raw_products