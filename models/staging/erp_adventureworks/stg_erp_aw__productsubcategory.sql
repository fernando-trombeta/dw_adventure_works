with
    source_productsubcategory as (
        select
            cast(productsubcategoryid as int) as id_product_sub_category
            , cast(productcategoryid as int) as id_product_category
            , cast(name as string) as sub_category_name
            , cast(rowguid as string) as rowguid
            , cast(modifieddate as timestamp) as modified_date

            /* columns created by stitch */
            , cast(_sdc_table_version as int) as _sdc_table_version
            , cast(_sdc_sequence as int) as _sdc_sequence
            , cast(_sdc_received_at as timestamp) as _sdc_received_at
            , cast(_sdc_batched_at as timestamp) as _sdc_batched_at
        from {{ source('erp_aw', 'productsubcategory') }}
    )

select *
from source_productsubcategory