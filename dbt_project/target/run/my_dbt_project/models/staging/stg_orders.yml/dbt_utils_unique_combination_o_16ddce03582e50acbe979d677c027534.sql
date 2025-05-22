select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      





with validation_errors as (

    select
        customer_id, order_id
    from `capstone-project-451604`.`capstone_dataset`.`stg_orders`
    group by customer_id, order_id
    having count(*) > 1

)

select *
from validation_errors



      
    ) dbt_internal_test