with
    source_salesorderdetail as (
        select
            cast(salesorderdetailid as int) as id_sales_order_detail
            , cast(salesorderid as int) as id_sales_order
            , cast(productid as int) as id_product
            , cast(specialofferid as int) as id_special_offer
            , cast(orderqty as int) as order_quantity
            , cast(unitprice as numeric) as unit_price
            , cast(unitpricediscount as numeric) as unit_price_discount
            , cast(carriertrackingnumber as string) as carrier_tracking_number
            , cast(rowguid	as string) as rowguid
            , cast(modifieddate as timestamp) as modified_date
        
             /* columns created by stitch */
            , cast(_sdc_table_version as int) as _sdc_table_version
            , cast(_sdc_sequence as int) as _sdc_sequence
            , cast(_sdc_received_at as timestamp) as _sdc_received_at
            , cast(_sdc_batched_at as timestamp) as _sdc_batched_at			
        from {{ source('erp_aw', 'salesorderdetail') }}
    )

select *
from source_salesorderdetail