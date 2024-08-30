{{ config
(
    post_hook="ALTER TABLE IABSA_BRA_REVIEW.DEV.DIM_COLOR ADD CONSTRAINT pk_color PRIMARY KEY (ID);",
)
}}

with src_color as
(
    select * from {{ ref("src_color") }}
)

select
    uuid_string() as id,
    trim(color) as name,
    created_at,
    updated_at,
    period
from src_color
