with
    sellers as (
        select
            *
        from {{ source('capstone_dataset', 'sellers') }}
    )

select *
from sellers
