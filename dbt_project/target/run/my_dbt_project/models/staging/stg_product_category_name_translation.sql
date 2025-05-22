

  create or replace view `capstone-project-451604`.`capstone_dataset`.`stg_product_category_name_translation`
  OPTIONS()
  as with
    product_category_name_translation as (
        select
            *
        from `capstone-project-451604`.`capstone_dataset`.`product_category_name_translation` p
        WHERE p.product_category_name IS NOT NULL
    )

select *
from product_category_name_translation;

