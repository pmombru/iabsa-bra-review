{{ config
(
    post_hook="ALTER TABLE IABSA_BRA_REVIEW.DEV.DIM_PRODUCT_CATEGORY ADD CONSTRAINT pk_product_category PRIMARY KEY (ID);",
)
}}

with src_category as
(
    select * from {{ ref("src_category") }}
)

select
    uuid_string() as id,
    category as name,
    created_at,
    updated_at,
    period
from src_category
