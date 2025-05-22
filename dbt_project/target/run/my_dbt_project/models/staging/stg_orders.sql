

  create or replace view `capstone-project-451604`.`capstone_dataset`.`stg_orders`
  OPTIONS()
  as with
    customers as (
        select
            *
        from `capstone-project-451604`.`capstone_dataset`.`orders`
    )

select *
from customers;

