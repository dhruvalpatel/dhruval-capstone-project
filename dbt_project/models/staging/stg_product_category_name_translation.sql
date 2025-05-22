with
    product_category_name_translation as (
        select
            *
        from {{ source('capstone_dataset', 'product_category_name_translation') }} p
        WHERE p.product_category_name IS NOT NULL
    )

select *
from product_category_name_translation
