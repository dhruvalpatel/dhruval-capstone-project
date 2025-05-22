

  create or replace view `capstone-project-451604`.`capstone_dataset`.`stg_customers`
  OPTIONS()
  as with
    customers as (
        select
            customer_id,
            customer_unique_id,
            customer_zip_code_prefix,
            customer_city,
            customer_state
        from `capstone-project-451604`.`capstone_dataset`.`customers`
    )

select *
from customers;

