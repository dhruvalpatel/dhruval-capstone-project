
  
    

    create or replace table `capstone-project-451604`.`capstone_dataset`.`dim_customers`
      
    
    cluster by customer_city

    OPTIONS()
    as (
      

SELECT
    customer_id,
    customer_unique_id,
    customer_city,
    customer_state,
    customer_zip_code_prefix
FROM `capstone-project-451604`.`capstone_dataset`.`customers`
    );
  