-- back compat for old kwarg name
  
  
        
            
                
                
            
                
                
            
        
    

    

    merge into `capstone-project-451604`.`capstone_dataset`.`fact_sales` as DBT_INTERNAL_DEST
        using (
with
    audit_data as (
        select
            *
        from `capstone-project-451604`.`capstone_dataset`.`audit_fact_sales`
    )

select *
from audit_data
        ) as DBT_INTERNAL_SOURCE
        on (
                    DBT_INTERNAL_SOURCE.order_id = DBT_INTERNAL_DEST.order_id
                ) and (
                    DBT_INTERNAL_SOURCE.product_id = DBT_INTERNAL_DEST.product_id
                )

    
    when matched then update set
        `order_id` = DBT_INTERNAL_SOURCE.`order_id`,`customer_id` = DBT_INTERNAL_SOURCE.`customer_id`,`product_id` = DBT_INTERNAL_SOURCE.`product_id`,`seller_id` = DBT_INTERNAL_SOURCE.`seller_id`,`order_purchase_timestamp` = DBT_INTERNAL_SOURCE.`order_purchase_timestamp`,`order_delivered_timestamp` = DBT_INTERNAL_SOURCE.`order_delivered_timestamp`,`days_to_deliver` = DBT_INTERNAL_SOURCE.`days_to_deliver`,`order_status` = DBT_INTERNAL_SOURCE.`order_status`,`payment_type` = DBT_INTERNAL_SOURCE.`payment_type`,`payment_installments` = DBT_INTERNAL_SOURCE.`payment_installments`,`payment_value` = DBT_INTERNAL_SOURCE.`payment_value`,`freight_value` = DBT_INTERNAL_SOURCE.`freight_value`,`customer_city` = DBT_INTERNAL_SOURCE.`customer_city`,`customer_state` = DBT_INTERNAL_SOURCE.`customer_state`,`seller_city` = DBT_INTERNAL_SOURCE.`seller_city`,`seller_state` = DBT_INTERNAL_SOURCE.`seller_state`
    

    when not matched then insert
        (`order_id`, `customer_id`, `product_id`, `seller_id`, `order_purchase_timestamp`, `order_delivered_timestamp`, `days_to_deliver`, `order_status`, `payment_type`, `payment_installments`, `payment_value`, `freight_value`, `customer_city`, `customer_state`, `seller_city`, `seller_state`)
    values
        (`order_id`, `customer_id`, `product_id`, `seller_id`, `order_purchase_timestamp`, `order_delivered_timestamp`, `days_to_deliver`, `order_status`, `payment_type`, `payment_installments`, `payment_value`, `freight_value`, `customer_city`, `customer_state`, `seller_city`, `seller_state`)


    