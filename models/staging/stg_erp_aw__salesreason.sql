with
    source_salesreason as (
        select
            cast(salesreasonid as int) as id_sales_reason
            , cast(name as string) as sales_reason_name
            , cast(reasontype as string) as reason_type			
            , cast(modifieddate as timestamp) as modified_date	

            /* columns created by stitch */
            , cast(_sdc_table_version as int) as _sdc_table_version
            , cast(_sdc_sequence as int) as _sdc_sequence
            , cast(_sdc_received_at as timestamp) as _sdc_received_at
            , cast(_sdc_batched_at as timestamp) as _sdc_batched_at		
        from {{ source('erp_aw', 'salesreason') }}
    )

select *
from source_salesreason