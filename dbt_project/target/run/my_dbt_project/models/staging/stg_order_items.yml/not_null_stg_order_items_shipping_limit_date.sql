select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select shipping_limit_date
from `capstone-project-451604`.`capstone_dataset`.`stg_order_items`
where shipping_limit_date is null



      
    ) dbt_internal_test