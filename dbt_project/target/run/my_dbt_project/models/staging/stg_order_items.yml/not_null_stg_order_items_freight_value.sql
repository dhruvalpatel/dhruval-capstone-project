select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select freight_value
from `capstone-project-451604`.`capstone_dataset`.`stg_order_items`
where freight_value is null



      
    ) dbt_internal_test