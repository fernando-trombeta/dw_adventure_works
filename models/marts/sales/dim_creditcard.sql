with
    creditcard as (
        select
            id_credit_card
            , card_type
            , expiration_month
            , expiration_year
        from {{ ref('stg_erp_aw__creditcard') }}
    )

    , transformed as (
        select
            row_number() over (order by id_credit_card) as sk_credit_card
            , *
        from creditcard
    )

select *
from transformed