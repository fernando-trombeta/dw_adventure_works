
/* The purpose of this test is to validate that Adventure Works has over 500 products */

with validation as (
    select
        count (distinct sk_product) as count_product
    from {{ ref('dim_product') }}
)

select * 
from validation
where count_product < 500