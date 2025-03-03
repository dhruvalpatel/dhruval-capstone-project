{{ config(
    materialized='incremental',
    incremental_strategy='merge',
    unique_key=['order_id', 'product_id'],
    partition_by={
        "field": "order_purchase_timestamp",
        "data_type": "timestamp",
        "granularity": "day"
    },
    cluster_by=["order_id"]
) }}
with
    audit_data as (
        select
            *
        from {{ ref('audit_fact_sales') }}
    )

select *
from audit_data