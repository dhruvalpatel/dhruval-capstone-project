
  
    

    create or replace table `capstone-project-451604`.`capstone_dataset`.`dim_sellers`
      
    
    

    OPTIONS()
    as (
      

SELECT
    seller_id,
    seller_city,
    seller_state,
    seller_zip_code_prefix
FROM `capstone-project-451604`.`capstone_dataset`.`sellers`
    );
  