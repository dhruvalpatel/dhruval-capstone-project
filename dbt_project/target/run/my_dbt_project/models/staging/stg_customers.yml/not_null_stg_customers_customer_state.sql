select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select customer_state
from `capstone-project-451604`.`capstone_dataset`.`stg_customers`
where customer_state is null



      
    ) dbt_internal_test