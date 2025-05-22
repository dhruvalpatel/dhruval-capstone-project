select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select order_approved_at
from `capstone-project-451604`.`capstone_dataset`.`stg_orders`
where order_approved_at is null



      
    ) dbt_internal_test