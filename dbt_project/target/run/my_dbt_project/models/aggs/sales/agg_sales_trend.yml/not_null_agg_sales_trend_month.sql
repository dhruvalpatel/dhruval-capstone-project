select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select month
from `capstone-project-451604`.`capstone_dataset`.`agg_sales_trend`
where month is null



      
    ) dbt_internal_test