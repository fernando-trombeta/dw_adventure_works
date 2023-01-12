with
    salesorderheadersalesreason as (
        select
            id_sales_order_header	
            , id_sales_reason            	
        from {{ ref('stg_erp_aw__salesorderheadersalesreason') }}
    )
    
    , salesreason as (
        select
            id_sales_reason
            , sales_reason_name
            --, reason_type            	
        from {{ ref('stg_erp_aw__salesreason') }}
    )    

    , joined as (
        select
            salesorderheadersalesreason.id_sales_order_header	
            --, salesreason.id_sales_reason
            --, salesreason.reason_type
            , salesreason.sales_reason_name
        from salesorderheadersalesreason
        left join salesreason on salesorderheadersalesreason.id_sales_reason = salesreason.id_sales_reason
    )

    , transformed as (
        select
            id_sales_order_header	
            --, id_sales_reason
            --, reason_type
            --, sales_reason_name
            , string_agg(sales_reason_name, ', ') as sales_reason_name_aggregated
           
        from joined
        group by id_sales_order_header
    )

select *
from transformed
    