with
    source_product as(
        select
            cast(productid as int) as id_product
            , cast(productmodelid as int) as id_product_model
            , cast(productsubcategoryid as int) id_product_sub_category

            , cast(name as string) as product_name
            , cast(productnumber as string) as product_number
            , cast(size as string) as product_size
            , cast(color as string) as product_color
            , cast(weight as numeric) as product_weight
            , cast(style as string) as product_style
            , cast(sellenddate as timestamp) as sell_end_date
            , cast(sellstartdate as timestamp) as sell_start_date
            , cast(safetystocklevel as int) as safety_stock_level
            , cast(finishedgoodsflag as boolean) as finished_goodsflag
            , cast(class as string) product_class
            , cast(makeflag as boolean) as make_flag
            , cast(reorderpoint as int) as reorder_point
            , cast(weightunitmeasurecode as string) as weight_unit_measure_code
            , cast(sizeunitmeasurecode as string) as size_unit_measure_code
            , cast(standardcost as numeric) as standard_cost
            , cast(listprice as numeric) as list_price
            , cast(productline as string) as product_line
            , cast(daystomanufacture as int) as days_to_manufacture
            , cast(rowguid as string) as rowguid
            , cast(modifieddate as timestamp) as modified_date
            		
            /* columns created by stitch */
            , cast(_sdc_table_version as int) as _sdc_table_version
            , cast(_sdc_sequence as int) as _sdc_sequence
            , cast(_sdc_received_at as timestamp) as _sdc_received_at
            , cast(_sdc_batched_at as timestamp) as _sdc_batched_at			
        from {{ source('erp_aw', 'product') }}
    )
select *
from source_product