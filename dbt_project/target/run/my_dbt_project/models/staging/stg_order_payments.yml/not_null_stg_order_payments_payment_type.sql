select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select payment_type
from `capstone-project-451604`.`capstone_dataset`.`stg_order_payments`
where payment_type is null



      
    ) dbt_internal_test