with
    salesorderheadersalesreason as (
        select *
        from {{ ref('stg_erp_aw__salesorderheadersalesreason') }}
    )
    
    , salesreason as (
        select *           	
        from {{ ref('stg_erp_aw__salesreason') }}
    )    

    , joined as (
        select
            salesorderheadersalesreason.id_sales_order_header
            , salesreason.sales_reason_name
        from salesorderheadersalesreason
        left join salesreason on salesorderheadersalesreason.id_sales_reason = salesreason.id_sales_reason
    )

    , transformed as (
        select
            id_sales_order_header
            , string_agg(sales_reason_name, ', ') as sales_reason_name_aggregated
           
        from joined
        group by id_sales_order_header
    )

select *
from transformed
    