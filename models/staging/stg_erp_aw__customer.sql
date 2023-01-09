with
    source_customer as (
        select
            cast(customerid as int) as id_customer
            , cast(personid as int) as id_person
            , cast(storeid as int) as id_store
            , cast(territoryid as int) as id_territory
            , cast(rowguid as string) as rowguid
            , cast(modifieddate as timestamp) as modified_date

            /* columns created by stitch */
            , cast(_sdc_table_version as int) as _sdc_table_version
            , cast(_sdc_sequence as int) as _sdc_sequence
            , cast(_sdc_received_at as timestamp) as _sdc_received_at
            , cast(_sdc_batched_at as timestamp) as _sdc_batched_at
        from {{ source('erp_aw', 'customer') }}
    )

select *
from source_customer