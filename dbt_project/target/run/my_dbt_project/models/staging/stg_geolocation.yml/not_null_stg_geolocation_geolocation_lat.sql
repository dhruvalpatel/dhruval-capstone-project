select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select geolocation_lat
from `capstone-project-451604`.`capstone_dataset`.`stg_geolocation`
where geolocation_lat is null



      
    ) dbt_internal_test