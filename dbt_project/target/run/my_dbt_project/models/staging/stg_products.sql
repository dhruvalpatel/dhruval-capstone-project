

  create or replace view `capstone-project-451604`.`capstone_dataset`.`stg_products`
  OPTIONS()
  as with
    products as (
        select
            *
        from `capstone-project-451604`.`capstone_dataset`.`products`
    )

select *
from products;

