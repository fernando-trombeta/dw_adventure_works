with
    source_salesorderheadersalesreason as(
        select
            cast(salesorderid as int) as id_sales_order_header	
            , cast(salesreasonid as int) as id_sales_reason
            , cast(modifieddate as timestamp) as modified_date

            /* columns created by stitch */
            , cast(_sdc_table_version as int) as _sdc_table_version
            , cast(_sdc_sequence as int) as _sdc_sequence
            , cast(_sdc_received_at as timestamp) as _sdc_received_at
            , cast(_sdc_batched_at as timestamp) as _sdc_batched_at	
        from {{ source('erp_aw', 'salesorderheadersalesreason') }}
    )
select *
from source_salesorderheadersalesreason

/* Essa tabela não tem chave primária??  */