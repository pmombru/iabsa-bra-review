with ae_product as
(select distinct product_category, product_name, scrapping_datetime from IABSA_BRA_REVIEW.RAW.ae_com),

amazon_product as
(select distinct product_category, product_name, scrapping_datetime from IABSA_BRA_REVIEW.RAW.amazon_com),

btemptd_product as
(select distinct product_category, product_name, scrapping_datetime from IABSA_BRA_REVIEW.RAW.btemptd_com),

calvinklein_product as
(select distinct product_category, product_name, scrapping_datetime from IABSA_BRA_REVIEW.RAW.calvinklein_com),

hankypanky_product as
(select distinct product_category, product_name, scrapping_datetime from IABSA_BRA_REVIEW.RAW.hankypanky_com),

macys_product as
(select distinct product_category, product_name, scrapping_datetime from IABSA_BRA_REVIEW.RAW.macys_com),

shop_nordstrom_product as
(select distinct product_category, product_name, scrapping_datetime from IABSA_BRA_REVIEW.RAW.shop_nordstrom_com),

us_topshop_product as
(select distinct product_category, product_name, scrapping_datetime from IABSA_BRA_REVIEW.RAW.us_topshop_com),

victoriassecret_product as
(select distinct product_category, product_name, scrapping_datetime from IABSA_BRA_REVIEW.RAW.victoriassecret_com)

select distinct
    product_category as category,
    product_name as name,
    to_timestamp(scrapping_datetime, 'DD-MM-YY HH24:MI') as created_at,
    to_timestamp(null, 'DD-MM-YY HH24:MI') as updated_at,
    lpad(month(to_timestamp(scrapping_datetime, 'DD-MM-YY HH24:MI'))||'-'||year(to_timestamp(scrapping_datetime, 'DD-MM-YY HH24:MI')), 7, '0') as period
from (
    select * from ae_product
    union
    select * from amazon_product
    union
    select * from btemptd_product
    union
    select * from calvinklein_product
    union
    select * from hankypanky_product
    union
    select * from macys_product
    union
    select * from shop_nordstrom_product
    union
    select * from victoriassecret_product
)