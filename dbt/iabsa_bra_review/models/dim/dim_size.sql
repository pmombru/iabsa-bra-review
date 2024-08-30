{{ config
(
    post_hook="ALTER TABLE IABSA_BRA_REVIEW.DEV.DIM_SIZE ADD CONSTRAINT pk_size PRIMARY KEY (ID);"
)
}}

with src_total_size as
(
    select
        size as name,
        case
            when trim(upper(size)) like '30%' or trim(upper(size)) like '32%' or trim(upper(size)) like '34%' or trim(upper(size)) like '36%' or trim(upper(size)) like '38%' or trim(upper(size)) like '40%' or trim(upper(size)) like '42%' or trim(upper(size)) like '44%' or trim(upper(size)) like '46%' then true
            when trim(upper(size)) in ('1X', '2X', '3X', '1SZ', '1X APPAREL', '2X (20W-22W)', '2X PLUS', '3X APPAREL') then true
            else false
        end as is_bra,
        case
            when trim(upper(size)) like '30%' or trim(upper(size)) like '32%' then 'Small'
            when trim(upper(size)) like '34%' or trim(upper(size)) like '36%' then 'Medium'
            when trim(upper(size)) like '38%' or trim(upper(size)) like '40%' then 'Large'
            when trim(upper(size)) like '42%' or trim(upper(size)) like '44%' or trim(upper(size)) like '46%' then 'Extra Large'
            when trim(upper(size)) in ('1X', '2X', '3X', '1SZ', '1X APPAREL', '2X (20W-22W)', '2X PLUS', '3X APPAREL') then 'Extra Large'
            else 'Not a bra'
        end as category,
        created_at,
        updated_at,
        period
    from {{ ref("src_total_size") }} t
),

total_size as
(
    select distinct * from src_total_size
)

select uuid_string() as id, * from total_size