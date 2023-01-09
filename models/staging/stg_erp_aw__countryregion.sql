with
    source_countryregion as (
        select
            cast(countryregioncode as string) as country_region_code
            , cast(name as string) as country_name
            , cast(modifieddate as timestamp) as modified_date

            /* columns created by stitch */				
            , cast(_sdc_sequence as int) as _sdc_sequence			
            , cast(_sdc_table_version as int) as _sdc_table_version		
            , cast(_sdc_received_at	as timestamp) as _sdc_received_at		
            , cast(_sdc_batched_at as timestamp) as _sdc_batched_at
        from {{ source('erp_aw', 'countryregion') }}
    )

select *
from source_countryregion