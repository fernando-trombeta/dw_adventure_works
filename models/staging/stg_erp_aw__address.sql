with
    source_address as (
        select
           -- primary key
           cast(addressid as int) as id_address

           -- foreign key
           , cast(stateprovinceid as int) as id_state_province

           , cast(addressline1 as string) as address_line_1		
           , cast(addressline2 as string) as address_line_2					
           , cast(city as string) as city			
           , cast(postalcode as string) as postal_code				
           , cast(spatiallocation as string) spatial_location			
           , cast(rowguid as string) as rowguid				
           , cast(modifieddate as timestamp) as modified_date

           -- columns created by stitch
           , cast(_sdc_table_version as int) as _sdc_table_version
           , cast(_sdc_sequence as int)	as _sdc_sequence
           , cast(_sdc_batched_at as timestamp) as _sdc_batched_at	
           , cast(_sdc_received_at as timestamp) as _sdc_received_at 
        from {{ source('erp_aw' , 'address') }}
    )

select *
from source_address