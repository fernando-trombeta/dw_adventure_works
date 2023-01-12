with
    product as (
        select
            id_product
            , id_product_model
            , id_product_sub_category
            , product_name
            , product_number
            , product_size
            , product_color
            , product_weight
            , product_style
            , product_class
            , product_line
            , list_price
            , standard_cost
            , sell_end_date
            , sell_start_date
            , safety_stock_level
            , finished_goodsflag
            , make_flag
            , reorder_point
            , weight_unit_measure_code
            , size_unit_measure_code
            , days_to_manufacture	
        from {{ ref('stg_erp_aw__product') }}
    )

    , productcategory as (
        select
            id_product_category
            , category_name
        from {{ ref('stg_erp_aw__productcategory') }}
    )

    , productsubcategory as (
        select
            id_product_sub_category
            , id_product_category
            , sub_category_name
        from {{ ref('stg_erp_aw__productsubcategory') }}
    )

    , joined as (
        select
            product.id_product
            , product.id_product_model
            , productcategory.id_product_category
            , productsubcategory.id_product_sub_category          
            , product.product_name
            , product.product_number
            , productcategory.category_name
            , productsubcategory.sub_category_name
            , product.product_size
            , product.product_color
            , product.product_weight
            , product.product_style
            , product.product_class
            , product.product_line
            , product.list_price
            , product.standard_cost
            , product.sell_start_date
            , product.sell_end_date
            , product.safety_stock_level
            , product.finished_goodsflag
            , product.make_flag
            , product.reorder_point
            , product.weight_unit_measure_code
            , product.size_unit_measure_code
            , product.days_to_manufacture
        from product
        left join productsubcategory on product.id_product_sub_category = productsubcategory.id_product_sub_category
        left join productcategory on productsubcategory.id_product_category = productcategory.id_product_category
    )

    , transformed as (
        select
            row_number() over (order by id_product) as sk_product
            , *
        from joined
    )

select *
from transformed