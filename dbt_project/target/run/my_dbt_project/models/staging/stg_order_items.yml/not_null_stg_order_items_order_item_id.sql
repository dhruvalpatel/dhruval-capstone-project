select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select order_item_id
from `capstone-project-451604`.`capstone_dataset`.`stg_order_items`
where order_item_id is null



      
    ) dbt_internal_test