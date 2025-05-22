with
    geolocation as (
        select
            geolocation_zip_code_prefix,
            geolocation_lat,
            geolocation_lng,
            geolocation_city,
            geolocation_state
        from `capstone-project-451604`.`capstone_dataset`.`geolocation`
    )

select *
from geolocation