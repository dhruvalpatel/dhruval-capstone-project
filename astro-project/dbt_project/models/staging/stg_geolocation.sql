with
    geolocation as (
        select
            geolocation_zip_code_prefix,
            geolocation_lat,
            geolocation_lng,
            geolocation_city,
            geolocation_state
        from {{ source('capstone_dataset', 'geolocation') }}
    )

select *
from geolocation
