with
    source_stateprovince as (
        select
            cast(stateprovinceid as int) as id_state_province
            , cast(territoryid as int) as id_territory
            , cast(name as string) as state_province_name
            , cast(stateprovincecode as string) as state_province_code
            , cast(countryregioncode as string) as country_region_code
            , cast(isonlystateprovinceflag as boolean) as is_only_state_province_flag
            , cast(rowguid as string) as rowguid
            , cast(modifieddate as timestamp) as modified_date

            /* columns created by stitch */
            , cast(_sdc_table_version as int) as _sdc_table_version
            , cast(_sdc_sequence as int) as _sdc_sequence
            , cast(_sdc_received_at as timestamp) as _sdc_received_at
            , cast(_sdc_batched_at as timestamp) as _sdc_batched_at				
        from {{ source('erp_aw', 'stateprovince') }}
    )

select *
from source_stateprovince