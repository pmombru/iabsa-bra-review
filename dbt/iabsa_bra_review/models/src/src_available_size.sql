with ae_transaction as
(select distinct retailer, brand_name, product_category, product_name, color, mrp, rating, review_count, scrapping_datetime, value as size
from IABSA_BRA_REVIEW.RAW.ae_com,
LATERAL SPLIT_TO_TABLE(ae_com.available_size, ', ')),

amazon_transaction as
(select distinct retailer, brand_name, product_category, product_name, color, mrp, rating, review_count, scrapping_datetime, value as size
from IABSA_BRA_REVIEW.RAW.amazon_com,
LATERAL SPLIT_TO_TABLE(amazon_com.available_size, ', ')),

btemptd_transaction as
(select distinct retailer, brand_name, product_category, product_name, color, mrp, rating, review_count, scrapping_datetime, value as size
from IABSA_BRA_REVIEW.RAW.btemptd_com,
LATERAL SPLIT_TO_TABLE(btemptd_com.available_size, ',')),

calvinklein_transaction as
(select distinct retailer, brand_name, product_category, product_name, color, mrp, rating, review_count, scrapping_datetime, value as size
from IABSA_BRA_REVIEW.RAW.calvinklein_com,
LATERAL SPLIT_TO_TABLE(calvinklein_com.available_size, ',')),

hankypanky_transaction as
(select distinct retailer, brand_name, product_category, product_name, color, mrp, rating, review_count, scrapping_datetime, value as size
from IABSA_BRA_REVIEW.RAW.hankypanky_com,
LATERAL SPLIT_TO_TABLE(hankypanky_com.available_size, ', ')),

macys_transaction as
(select distinct retailer, brand_name, product_category, product_name, color, mrp, rating, review_count, scrapping_datetime, value as size
from IABSA_BRA_REVIEW.RAW.macys_com,
LATERAL SPLIT_TO_TABLE(macys_com.available_size, ', ')),

shop_nordstrom_transaction as
(select distinct retailer, brand_name, product_category, product_name, color, mrp, rating, review_count, scrapping_datetime, value as size
from IABSA_BRA_REVIEW.RAW.shop_nordstrom_com,
LATERAL SPLIT_TO_TABLE(shop_nordstrom_com.available_size, ', ')),

us_topshop_transaction as
(select distinct retailer, brand_name, product_category, product_name, color, mrp, rating, review_count, scrapping_datetime, value as size
from IABSA_BRA_REVIEW.RAW.us_topshop_com,
LATERAL SPLIT_TO_TABLE(us_topshop_com.available_size, ', ')),

victoriassecret_transaction as
(select distinct retailer, brand_name, product_category, product_name, color, mrp, rating, review_count, scrapping_datetime, value as size
from IABSA_BRA_REVIEW.RAW.victoriassecret_com,
LATERAL SPLIT_TO_TABLE(victoriassecret_com.available_size, ', '))

select distinct
    retailer as vendor,
    case
        when trim(brand_name) in ('WACOAL', 'Wacoal', 'ref=w_bl_sl_l_b_ap_web_2603426011?ie=UTF8&node=2603426011&field-lbr_brands_browse-bin=Wacoal') then 'Wacoal'
        when trim(brand_name) in ('CALVIN KLEIN', 'Calvin Klein', 'Calvin Klein Modern Cotton', 'Calvin Klein Performance', 'Calvin-Klein', 'ref=w_bl_sl_l_ap_ap_web_2586685011?ie=UTF8&node=2586685011&field-lbr_brands_browse-bin=Calvin+Klein') then 'Calvin Klein'
        when trim(brand_name) in ('HANKY PANKY', 'Hanky Panky', 'Hanky-Panky', 'HankyPanky') then 'Hanky Panky'
        when trim(brand_name) in ('Victoria''s Secret', 'Victoria''s Secret Pink', 'Victorias-Secret') then 'Victoria''s Secret'
        when trim(brand_name) in ('B.TEMPT''D BY WACOAL', 'b-temptd', 'b.tempt''d', 'b.tempt''d by Wacoal', 'ref=w_bl_sl_l_b_ap_web_2586451011?ie=UTF8&node=2586451011&field-lbr_brands_browse-bin=b.tempt%27d') then 'b.tempt''d'
        else trim(brand_name)
    end as brand,
    product_category,
    product_name,
    color,
    mrp,
    rating,
    review_count,
    to_timestamp(scrapping_datetime, 'DD-MM-YY HH24:MI') as created_at,
    to_timestamp(null, 'DD-MM-YY HH24:MI') as updated_at,
    lpad(month(to_timestamp(scrapping_datetime, 'DD-MM-YY HH24:MI'))||'-'||year(to_timestamp(scrapping_datetime, 'DD-MM-YY HH24:MI')), 7, '0') as period,
    size
from (
    select * from ae_transaction
    union
    select * from amazon_transaction
    union
    select * from btemptd_transaction
    union
    select * from calvinklein_transaction
    union
    select * from hankypanky_transaction
    union
    select * from macys_transaction
    union
    select * from shop_nordstrom_transaction
    union
    select * from victoriassecret_transaction
)