with
    source_person as (
        select
            cast(businessentityid as int) as id_business_entity
            , cast(title as string) as title
            /* concat full_name */
            , cast((firstname || ' ' || lastname) as string) as full_name  
            , cast(firstname as string) as first_name
            , cast(middlename as string) as middle_name
            , cast(lastname as string) as last_name
            , cast(persontype as string) as person_type
            , cast(namestyle as boolean) as name_style
            , cast(suffix as string) as suffix
            , cast(emailpromotion as int) as email_promotion
            , cast(rowguid as string) as rowguid
            , cast(modifieddate as timestamp) as modified_date

            /* columns created by stitch */
            , cast(_sdc_table_version as int) as _sdc_table_version
            , cast(_sdc_sequence as int) as _sdc_sequence
            , cast(_sdc_received_at as timestamp) as _sdc_received_at
            , cast(_sdc_batched_at as timestamp) as _sdc_batched_at			
        from {{ source('erp_aw' , 'person') }}
    )

select *
from source_person