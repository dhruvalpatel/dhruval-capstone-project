
with
    audit_data as (
        select
            *
        from `capstone-project-451604`.`capstone_dataset`.`audit_fact_sales`
    )

select *
from audit_data