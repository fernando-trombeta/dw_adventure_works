with
    address as (
        select *
        from {{ ref('dim_address') }}
    )

    , creditcard as (
        select *
        from {{ ref('dim_creditcard') }}
    )

    , customer as (
        select *
        from {{ ref('dim_customer') }}
    )

    , product as (
        select *
        from {{ ref('dim_product') }}
    )

    , salesreason as (
        select *
        from {{ ref('dim_salesreason') }}
    )

    , salesorderheader as (
        select 
            id_sales_order_header
            , customer.sk_customer as fk_customer
            , address.id_ship_to_address as fk_address
            , creditcard.sk_credit_card as fk_credit_card
            , case 
                when order_status = 1 then 'In process'
                when order_status = 2 then 'Approved'
                when order_status = 3 then 'Backordered'
                when order_status = 4 then 'Rejected'
                when order_status = 5 then 'Shipped'
                when order_status = 6 then 'Cancelled'
                else 'no_status'
            end as order_status_name
            , stg_salesorderheader.id_territory
            , stg_salesorderheader.id_currency_rate
            , stg_salesorderheader.id_sales_person
            , stg_salesorderheader.freight
            , stg_salesorderheader.tax_amt
            , stg_salesorderheader.sub_total
            , stg_salesorderheader.total_due
            , stg_salesorderheader.order_date
            , stg_salesorderheader.due_date
            , stg_salesorderheader.ship_date

        from {{ ref('stg_erp_aw__salesorderheader') }} as stg_salesorderheader
        left join customer on stg_salesorderheader.id_customer = customer.id_customer
        left join creditcard on stg_salesorderheader.id_credit_card = creditcard.id_credit_card
        left join address on stg_salesorderheader.id_ship_to_address = address.id_ship_to_address
    )

    , salesorderdetail as (
        select
            id_sales_order_detail
            , stg_salesorderdetail.id_sales_order_header
            , product.sk_product as fk_product
            , stg_salesorderdetail.id_special_offer
            , stg_salesorderdetail.order_quantity
            , stg_salesorderdetail.unit_price
            , stg_salesorderdetail.unit_price_discount
            , ifnull(salesreason.sales_reason_name_aggregated,'Not indicated') as reason_name_final
        
        from {{ ref('stg_erp_aw__salesorderdetail') }} as stg_salesorderdetail
        left join product on stg_salesorderdetail.id_product = product.id_product
        left join salesreason on stg_salesorderdetail.id_sales_order_header = salesreason.id_sales_order_header
    )

    /* final_joined for table salesorderdetail and table salesorderheader */
    , final_joined as (
        select
            salesorderheader.id_sales_order_header
            , salesorderdetail.id_sales_order_detail
            , salesorderdetail.fk_product
            , salesorderheader.fk_customer
            , salesorderheader.fk_address
            , salesorderheader.fk_credit_card
            , salesorderheader.id_territory
            , salesorderheader.id_currency_rate
            , salesorderheader.id_sales_person
            , salesorderdetail.id_special_offer
            , salesorderdetail.order_quantity
            , salesorderdetail.unit_price
            , salesorderdetail.unit_price_discount
            , salesorderheader.tax_amt
            , salesorderheader.sub_total
            , salesorderheader.freight
            , salesorderheader.total_due
            , salesorderheader.order_date
            , salesorderheader.ship_date
            , salesorderheader.due_date
            , salesorderheader.order_status_name
            , salesorderdetail.reason_name_final
            --, salesorderdetail.id_sales_order_header

        from salesorderdetail 
        left join salesorderheader on salesorderdetail.id_sales_order_header = salesorderheader.id_sales_order_header
    )

    , transformed as (
        select
            *
            , (unit_price * order_quantity) as revenue
            , {{ dbt_utils.surrogate_key(['id_sales_order_header', 'fk_product']) }} as sk_fct_sales
        from final_joined
    )

select *
from transformed

    

    

    