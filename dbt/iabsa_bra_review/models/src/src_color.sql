with ae_prod_color as
(select distinct color, scrapping_datetime from IABSA_BRA_REVIEW.RAW.ae_com),

amazon_prod_color as
(select distinct color, scrapping_datetime from IABSA_BRA_REVIEW.RAW.amazon_com),

btemptd_prod_color as
(select distinct color, scrapping_datetime from IABSA_BRA_REVIEW.RAW.btemptd_com),

calvinklein_prod_color as
(select distinct color, scrapping_datetime from IABSA_BRA_REVIEW.RAW.calvinklein_com),

hankypanky_prod_color as
(select distinct color, scrapping_datetime from IABSA_BRA_REVIEW.RAW.hankypanky_com),

macys_prod_color as
(select distinct color, scrapping_datetime from IABSA_BRA_REVIEW.RAW.macys_com),

shop_nordstrom_prod_color as
(select distinct color, scrapping_datetime from IABSA_BRA_REVIEW.RAW.shop_nordstrom_com),

us_topshop_prod_color as
(select distinct color, scrapping_datetime from IABSA_BRA_REVIEW.RAW.us_topshop_com),

victoriassecret_prod_color as
(select distinct color, scrapping_datetime from IABSA_BRA_REVIEW.RAW.victoriassecret_com)

select distinct
    color,
    to_timestamp(scrapping_datetime, 'DD-MM-YY HH24:MI') as created_at,
    to_timestamp(null, 'DD-MM-YY HH24:MI') as updated_at,
    lpad(month(to_timestamp(scrapping_datetime, 'DD-MM-YY HH24:MI'))||'-'||year(to_timestamp(scrapping_datetime, 'DD-MM-YY HH24:MI')), 7, '0') as period
from (
    select * from ae_prod_color
    union
    select * from amazon_prod_color
    union
    select * from btemptd_prod_color
    union
    select * from calvinklein_prod_color
    union
    select * from hankypanky_prod_color
    union
    select * from macys_prod_color
    union
    select * from shop_nordstrom_prod_color
    union
    select * from victoriassecret_prod_color
)