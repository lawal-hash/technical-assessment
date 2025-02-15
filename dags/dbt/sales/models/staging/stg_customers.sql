with raw_customers as ( 
    select  cust_id as customer_id,
    cust_address as customer_address,
    split_part(cust_address, ',',2 ) as city,
    substring(split_part(cust_address, ',',3) from 1 for 3) as state_code,
    cust_age as customer_age,
    effective_start_date,
    effective_end_date,
    current_ind as current_indicator
    from  {{source('sales', 'customers')}}
    )
select customer_id,city, 
        state_code, 
        customer_age, 
        current_indicator 
from raw_customers
