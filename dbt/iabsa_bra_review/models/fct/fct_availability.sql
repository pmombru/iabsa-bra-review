{{ config
(
    post_hook="ALTER TABLE IABSA_BRA_REVIEW.DEV.FCT_AVAILABILITY ADD CONSTRAINT pk_availability PRIMARY KEY (ID);
    ALTER TABLE IABSA_BRA_REVIEW.DEV.FCT_AVAILABILITY ADD CONSTRAINT fk_vendor FOREIGN KEY (VENDOR_ID) REFERENCES IABSA_BRA_REVIEW.DEV.DIM_VENDOR (ID);"
)
}}

with src_existing_size as
(
    select 
     v.id as vendor_id,
     s.id as size_id,
     s.category as size_group,
     t.created_at,
     t.updated_at,
     t.period
    from {{ ref("src_total_size") }} t
    left join {{ ref("dim_vendor") }} v on v.name = t.vendor
    left join {{ ref("dim_size") }} s on s.name = t.size
    where s.is_bra
),
src_available_size as
(
    select
     v.id as vendor_id,
     s.id as size_id,
     s.category as size_group,
     t.created_at,
     t.updated_at,
     t.period
    from {{ ref("src_available_size") }} t
    left join {{ ref("dim_vendor") }} v on v.name = t.vendor
    left join {{ ref("dim_size") }} s on s.name = t.size
    where s.is_bra
),
total_existing_size as 
(
    select 
        vendor_id,
        size_group,
        created_at,
        updated_at,
        period,
        count(*) as total
    from src_existing_size
    group by vendor_id, size_group, created_at, updated_at, period
),
total_available_size as 
(
    select
        vendor_id,
        size_group,
        created_at,
        updated_at,
        period,
        count(*) as total
    from src_available_size
    group by vendor_id, size_group, created_at, updated_at, period
)

select 
    uuid_string() as id,
    t.vendor_id,
    t.size_group,
    t.created_at,
    t.updated_at,
    t.period,
    t.total as total_existing,
    a.total as total_available,
    a.total/t.total as availability_perc
    from total_existing_size as t
    left join total_available_size as a on
        t.vendor_id = a.vendor_id
        and t.size_group = a.size_group
        and t.created_at = a.created_at
        --and t.updated_at = a.updated_at
        and t.period = a.period
