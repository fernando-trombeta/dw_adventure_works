with
    address as (
        select
            id_address
            , id_state_province
            , address_line_1		
            , city			
            , postal_code	
        from {{ ref('stg_erp_aw__address') }}
    )

    , countryregion as (
        select
            country_region_code
            , country_name
        from {{ ref('stg_erp_aw__countryregion') }}
    )

    , stateprovince as (
        select
            id_state_province
            , id_territory
            , state_province_name
            , state_province_code
            , country_region_code
            , is_only_state_province_flag
        from {{ ref('stg_erp_aw__stateprovince') }}
    )

    , salesorderheader as (
        select 
            distinct(id_ship_to_address)
        from {{ref('stg_erp_aw__salesorderheader')}}
)

    , joined as (
        select    
            address.id_address
            , stateprovince.id_state_province
            , stateprovince.id_territory
            , countryregion.country_region_code
            , address.address_line_1		
            , address.city			
            , address.postal_code
            , countryregion.country_name
            , stateprovince.state_province_name
            , stateprovince.state_province_code
            , stateprovince.is_only_state_province_flag
            , salesorderheader.id_ship_to_address
        from address
        left join stateprovince on address.id_state_province = stateprovince.id_state_province
        left join countryregion on stateprovince.country_region_code = countryregion.country_region_code
        left join salesorderheader on address.id_address = salesorderheader.id_ship_to_address
    )

    , transformed as (
        select
            row_number() over (order by id_address) as sk_address
            , *
        from joined
    )

select *
from transformed