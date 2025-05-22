select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select product_category_name_english
from `capstone-project-451604`.`capstone_dataset`.`stg_product_category_name_translation`
where product_category_name_english is null



      
    ) dbt_internal_test