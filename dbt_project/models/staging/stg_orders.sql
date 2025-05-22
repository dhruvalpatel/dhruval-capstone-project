with
    customers as (
        select
            *
        from {{ source('capstone_dataset', 'orders') }}
    )

select *
from customers
