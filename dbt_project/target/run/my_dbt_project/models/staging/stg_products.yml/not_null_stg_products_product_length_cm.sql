select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select product_length_cm
from `capstone-project-451604`.`capstone_dataset`.`stg_products`
where product_length_cm is null



      
    ) dbt_internal_test