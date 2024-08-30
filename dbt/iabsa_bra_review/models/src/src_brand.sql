with ae_retailer as
(select distinct brand_name, scrapping_datetime from IABSA_BRA_REVIEW.RAW.ae_com),

amazon_retailer as
(select distinct brand_name, scrapping_datetime from IABSA_BRA_REVIEW.RAW.amazon_com),

btemptd_retailer as
(select distinct brand_name, scrapping_datetime from IABSA_BRA_REVIEW.RAW.btemptd_com),

calvinklein_retailer as
(select distinct brand_name, scrapping_datetime from IABSA_BRA_REVIEW.RAW.calvinklein_com),

hankypanky_retailer as
(select distinct brand_name, scrapping_datetime from IABSA_BRA_REVIEW.RAW.hankypanky_com),

macys_retailer as
(select distinct brand_name, scrapping_datetime from IABSA_BRA_REVIEW.RAW.macys_com),

shop_nordstrom_retailer as
(select distinct brand_name, scrapping_datetime from IABSA_BRA_REVIEW.RAW.shop_nordstrom_com),

us_topshop_retailer as
(select distinct brand_name, scrapping_datetime from IABSA_BRA_REVIEW.RAW.us_topshop_com),

victoriassecret_retailer as
(select distinct brand_name, scrapping_datetime from IABSA_BRA_REVIEW.RAW.victoriassecret_com)

select distinct
    case
        when trim(brand_name) in ('WACOAL', 'Wacoal', 'ref=w_bl_sl_l_b_ap_web_2603426011?ie=UTF8&node=2603426011&field-lbr_brands_browse-bin=Wacoal') then 'Wacoal'
        when trim(brand_name) in ('CALVIN KLEIN', 'Calvin Klein', 'Calvin Klein Modern Cotton', 'Calvin Klein Performance', 'Calvin-Klein', 'ref=w_bl_sl_l_ap_ap_web_2586685011?ie=UTF8&node=2586685011&field-lbr_brands_browse-bin=Calvin+Klein') then 'Calvin Klein'
        when trim(brand_name) in ('HANKY PANKY', 'Hanky Panky', 'Hanky-Panky', 'HankyPanky') then 'Hanky Panky'
        when trim(brand_name) in ('Victoria''s Secret', 'Victoria''s Secret Pink', 'Victorias-Secret') then 'Victoria''s Secret'
        when trim(brand_name) in ('B.TEMPT''D BY WACOAL', 'b-temptd', 'b.tempt''d', 'b.tempt''d by Wacoal', 'ref=w_bl_sl_l_b_ap_web_2586451011?ie=UTF8&node=2586451011&field-lbr_brands_browse-bin=b.tempt%27d') then 'b.tempt''d'
        else trim(brand_name)
    end as brand
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