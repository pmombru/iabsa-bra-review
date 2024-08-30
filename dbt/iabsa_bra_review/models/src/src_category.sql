with ae_prod_category as
(select distinct product_category, scrapping_datetime from IABSA_BRA_REVIEW.RAW.ae_com),

amazon_prod_category as
(select distinct product_category, scrapping_datetime from IABSA_BRA_REVIEW.RAW.amazon_com),

btemptd_prod_category as
(select distinct product_category, scrapping_datetime from IABSA_BRA_REVIEW.RAW.btemptd_com),

calvinklein_prod_category as
(select distinct product_category, scrapping_datetime from IABSA_BRA_REVIEW.RAW.calvinklein_com),

hankypanky_prod_category as
(select distinct product_category, scrapping_datetime from IABSA_BRA_REVIEW.RAW.hankypanky_com),

macys_prod_category as
(select distinct product_category, scrapping_datetime from IABSA_BRA_REVIEW.RAW.macys_com),

shop_nordstrom_prod_category as
(select distinct product_category, scrapping_datetime from IABSA_BRA_REVIEW.RAW.shop_nordstrom_com),

us_topshop_prod_category as
(select distinct product_category, scrapping_datetime from IABSA_BRA_REVIEW.RAW.us_topshop_com),

victoriassecret_prod_category as
(select distinct product_category, scrapping_datetime from IABSA_BRA_REVIEW.RAW.victoriassecret_com)

select distinct
    product_category as category,
    to_timestamp(scrapping_datetime, 'DD-MM-YY HH24:MI') as created_at,
    to_timestamp(null, 'DD-MM-YY HH24:MI') as updated_at,
    lpad(month(to_timestamp(scrapping_datetime, 'DD-MM-YY HH24:MI'))||'-'||year(to_timestamp(scrapping_datetime, 'DD-MM-YY HH24:MI')), 7, '0') as period
from (
    select * from ae_prod_category
    union
    select * from amazon_prod_category
    union
    select * from btemptd_prod_category
    union
    select * from calvinklein_prod_category
    union
    select * from hankypanky_prod_category
    union
    select * from macys_prod_category
    union
    select * from shop_nordstrom_prod_category
    union
    select * from victoriassecret_prod_category
)