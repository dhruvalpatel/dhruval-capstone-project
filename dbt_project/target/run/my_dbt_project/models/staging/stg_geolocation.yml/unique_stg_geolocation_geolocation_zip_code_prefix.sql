select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

with dbt_test__target as (

  select geolocation_zip_code_prefix as unique_field
  from `capstone-project-451604`.`capstone_dataset`.`stg_geolocation`
  where geolocation_zip_code_prefix is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1



      
    ) dbt_internal_test