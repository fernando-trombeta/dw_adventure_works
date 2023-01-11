with
    source_creditcard as(
        select
            cast(creditcardid as int) as id_credit_card
            , cast(cardtype as string) as card_type
            , cast(expmonth as int) as expiration_month
            , cast(expyear as int) as expiration_year
            --, cardnumber
            , cast(modifieddate as timestamp) as modified_date

            /* columns created by stitch */
            , cast(_sdc_table_version as int) as _sdc_table_version
            , cast(_sdc_sequence as int) as _sdc_sequence
            , cast(_sdc_received_at as timestamp) as _sdc_received_at
            , cast(_sdc_batched_at as timestamp) as _sdc_batched_at
        from {{ source('erp_aw', 'creditcard') }}
    )    

select *
from  source_creditcard


/* credit card number is a sensitive information */