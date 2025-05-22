with
    order_payments as (
        select
            order_id,
            payment_sequential,
            payment_type,
            payment_installments,
            payment_value
        from {{ source('capstone_dataset', 'order_payments') }}
    )

select *
from order_payments
