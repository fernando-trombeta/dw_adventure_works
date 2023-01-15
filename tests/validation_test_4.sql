
/* The purpose of this test is to validate that Adventure Works had revenue of 110373889 */

with
    validation as (
        select
            sum (unit_price * order_quantity) as result_revenue
        from {{ref ('fct_sale')}} 
        where order_date between '2011-05-31' and '2014-06-30'
    )

select * 
from validation 
where result_revenue != 110373889