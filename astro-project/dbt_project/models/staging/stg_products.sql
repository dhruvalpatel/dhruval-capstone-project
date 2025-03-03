with
    products as (
        select
            *
        from {{ source('capstone_dataset', 'products') }}
    )

select *
from products
