with
    source_salesorderheader as (
        select
            cast(salesorderid as int) as id_sales_order_header
            , cast(customerid as int) as id_customer
            , cast(territoryid as int) as id_territory
            , cast(shipmethodid as int) as id_ship_method
            , cast(shiptoaddressid as int) as id_ship_to_address
            , cast(billtoaddressid as int) as id_bill_to_address
            , cast(currencyrateid as int) as id_currency_rate
            , cast(creditcardid as int) as id_credit_card
            , cast(salespersonid as int) as id_sales_person
            , cast(freight as numeric) as freight
            , cast(taxamt as numeric) as tax_amt
            , cast(subtotal as numeric) as sub_total
            , cast(totaldue as numeric) as total_due
            , cast(orderdate as timestamp) as order_date
            , cast(duedate as timestamp) as due_date
            , cast(shipdate as timestamp) as ship_date
            , cast(status as int) as order_status
            , cast(purchaseordernumber as string) as purchase_order_number
            , cast(onlineorderflag as boolean) as online_order_flag
            , cast(creditcardapprovalcode as string) as creditcard_approval_code
            , cast(revisionnumber as int) as revision_number
            , cast(accountnumber as string) as account_number
            , cast(rowguid as string) as rowguid
            , cast(modifieddate as timestamp) as modified_date

            /* columns created by stitch */
            , cast(_sdc_table_version as int) as _sdc_table_version
            , cast(_sdc_sequence as int) as _sdc_sequence
            , cast(_sdc_received_at as timestamp) as _sdc_received_at
            , cast(_sdc_batched_at as timestamp) as _sdc_batched_at				
        from {{ source('erp_aw', 'salesorderheader') }}
    )

select *
from source_salesorderheader