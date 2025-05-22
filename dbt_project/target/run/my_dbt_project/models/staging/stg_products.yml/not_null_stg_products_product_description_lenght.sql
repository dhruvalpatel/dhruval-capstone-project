select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select product_description_lenght
from `capstone-project-451604`.`capstone_dataset`.`stg_products`
where product_description_lenght is null



      
    ) dbt_internal_test