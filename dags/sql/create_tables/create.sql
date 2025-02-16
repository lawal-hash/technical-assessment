CREATE SCHEMA IF NOT EXISTS sales;

CREATE TABLE IF NOT EXISTS sales.customers (
    cust_id int4 NOT NULL,
    cust_address varchar(50) NULL,
    cust_age int4 NULL,
    effective_start_date varchar(50) NULL,
    effective_end_date varchar(50) NULL,
    current_ind varchar(50) NULL,
    CONSTRAINT customer_pk PRIMARY KEY (cust_id)
);


CREATE TABLE IF NOT EXISTS sales.products (
    product_id int4 NULL,
    product_name varchar(50) NULL,
    product_price int4 NULL,
    effective_start_date varchar(50) NULL,
    effective_end_date varchar(50) NULL,
    current_ind varchar(50) NULL,
    CONSTRAINT product_unique UNIQUE (product_id, effective_start_date, effective_end_date)
);

CREATE TABLE IF NOT EXISTS sales.transactions (
    order_id int4 NULL,
    product_id int4 NULL,
    cust_id int4 NULL,
    product_quantity int4 NULL,
    order_date varchar(50) NULL,
    CONSTRAINT sales_transactions_customer_fk FOREIGN KEY (cust_id) REFERENCES sales.customer(cust_id)
);