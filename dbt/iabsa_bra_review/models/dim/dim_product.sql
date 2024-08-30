{{ config
(
    post_hook="ALTER TABLE IABSA_BRA_REVIEW.DEV.DIM_PRODUCT ADD CONSTRAINT pk_product PRIMARY KEY (ID);
    ALTER TABLE IABSA_BRA_REVIEW.DEV.DIM_PRODUCT ADD CONSTRAINT fk_product_category FOREIGN KEY (CATEGORY_ID) REFERENCES IABSA_BRA_REVIEW.DEV.DIM_PRODUCT_CATEGORY (ID);",
)
}}

with src_product as
(
    select p.*, c.id as category_id
    from {{ ref("src_product") }} as p
    join {{ ref("dim_product_category") }} as c on c.name = p.category
)


select
    uuid_string() as id,
    category_id,
    name as name,
    created_at,
    updated_at,
    period
from src_product
