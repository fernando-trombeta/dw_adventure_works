with
    customer as (
        select
            id_customer
            , id_person
            , id_store
            , id_territory
        from {{ ref('stg_erp_aw__customer') }}
    )

    , person as (
        select
            id_person
            , person_title
            , full_name  
            , first_name
            , middle_name
            , last_name
            , person_type
            , name_style
            , suffix
            , email_promotion
        from {{ ref('stg_erp_aw__person') }}
    )

    , store as (
        select
            id_store
            , id_sales_person
            , store_name
        from {{ ref('stg_erp_aw__store') }}
    )

    , joined as (
        select
            customer.id_customer
            , customer.id_territory
            , person.id_person
            , store.id_store
            , store.id_sales_person
            , person.person_title
            , person.full_name  
            , person.first_name
            , person.middle_name
            , person.last_name
            , store.store_name
            , person.email_promotion
            , person.person_type
            , person.name_style
            , person.suffix
        from customer
        left join person on customer.id_person = person.id_person
        left join store on customer.id_store = store.id_store
    )

    , transformed as (
        select
            row_number() over (order by id_customer) as sk_customer
            , *
        from joined
    )

select *
from transformed