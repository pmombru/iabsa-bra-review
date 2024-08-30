{{ config
(
    post_hook="ALTER TABLE IABSA_BRA_REVIEW.DEV.DIM_BRAND ADD CONSTRAINT pk_brand PRIMARY KEY (ID);",
)
}}

with src_brand as
(
    select * from {{ ref("src_brand") }}
),

brand_grouped as 
(
    select
        brand as name
    from src_brand
    group by brand
)

select
    uuid_string() as id,
    name,
    getdate() as created_at,
    to_timestamp(null) as updated_at
from brand_grouped
