select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select product_name_lenght
from `capstone-project-451604`.`capstone_dataset`.`stg_products`
where product_name_lenght is null



      
    ) dbt_internal_test