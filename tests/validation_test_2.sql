
/* The purpose of this test is to validate that Adventure Works had a Distinct Sales Order ID of 31465 */

with
    validation as (
        select
            count (distinct id_sales_order_header) as num_of_sales_order_header
        from {{ref ('fct_sale')}} 
        where order_date between '2011-05-31' and '2014-06-30'
    )

select * 
from validation 
where num_of_sales_order_header != 31465