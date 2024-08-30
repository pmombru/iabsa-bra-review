with ae_retailer as
(select distinct retailer, scrapping_datetime from IABSA_BRA_REVIEW.RAW.ae_com),

amazon_retailer as
(select distinct retailer, scrapping_datetime from IABSA_BRA_REVIEW.RAW.amazon_com),

btemptd_retailer as
(select distinct retailer, scrapping_datetime from IABSA_BRA_REVIEW.RAW.btemptd_com),

calvinklein_retailer as
(select distinct retailer, scrapping_datetime from IABSA_BRA_REVIEW.RAW.calvinklein_com),

hankypanky_retailer as
(select distinct retailer, scrapping_datetime from IABSA_BRA_REVIEW.RAW.hankypanky_com),

macys_retailer as
(select distinct retailer, scrapping_datetime from IABSA_BRA_REVIEW.RAW.macys_com),

shop_nordstrom_retailer as
(select distinct retailer, scrapping_datetime from IABSA_BRA_REVIEW.RAW.shop_nordstrom_com),

us_topshop_retailer as
(select distinct retailer, scrapping_datetime from IABSA_BRA_REVIEW.RAW.us_topshop_com),

victoriassecret_retailer as
(select distinct retailer, scrapping_datetime from IABSA_BRA_REVIEW.RAW.victoriassecret_com)

select distinct
    retailer as vendor,
    to_timestamp(scrapping_datetime, 'DD-MM-YY HH24:MI') as created_at,
    to_timestamp(null, 'DD-MM-YY HH24:MI') as updated_at,
    lpad(month(to_timestamp(scrapping_datetime, 'DD-MM-YY HH24:MI'))||'-'||year(to_timestamp(scrapping_datetime, 'DD-MM-YY HH24:MI')), 7, '0') as period
from (
    select * from ae_retailer
    union
    select * from amazon_retailer
    union
    select * from btemptd_retailer
    union
    select * from calvinklein_retailer
    union
    select * from hankypanky_retailer
    union
    select * from macys_retailer
    union
    select * from shop_nordstrom_retailer
    union
    select * from victoriassecret_retailer
)