with
    source_store as (
        select
            cast(businessentityid as int) as id_store
            , cast(salespersonid as int) as id_sales_person
            , cast(name as string) as store_name
            , cast(rowguid as string) as rowguid
            , cast(modifieddate as timestamp) as modified_date		

            /* columns created by stitch */
            , cast(_sdc_table_version as int) as _sdc_table_version
            , cast(_sdc_sequence as int) as _sdc_sequence
            , cast(_sdc_received_at as timestamp) as _sdc_received_at
            , cast(_sdc_batched_at as timestamp) as _sdc_batched_at	
        from {{ source('erp_aw', 'store') }}
    )

select *
from source_store