
    
    

with dbt_test__target as (

  select geolocation_lat as unique_field
  from `capstone-project-451604`.`capstone_dataset`.`stg_geolocation`
  where geolocation_lat is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


