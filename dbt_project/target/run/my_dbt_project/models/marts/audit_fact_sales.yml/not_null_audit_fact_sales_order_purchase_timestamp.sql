select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select order_purchase_timestamp
from `capstone-project-451604`.`capstone_dataset`.`audit_fact_sales`
where order_purchase_timestamp is null



      
    ) dbt_internal_test