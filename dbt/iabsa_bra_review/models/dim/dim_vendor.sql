{{ config
(
    post_hook="ALTER TABLE IABSA_BRA_REVIEW.DEV.DIM_VENDOR ADD CONSTRAINT pk_vendor PRIMARY KEY (ID);",
)
}}

with src_vendor as
(
    select * from {{ ref("src_vendor") }}
)

select
    uuid_string() as id,
    vendor as name,
    created_at,
    updated_at,
    period
from src_vendor
