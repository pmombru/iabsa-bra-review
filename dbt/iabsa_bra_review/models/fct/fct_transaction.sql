{{ config
(
    post_hook="ALTER TABLE IABSA_BRA_REVIEW.DEV.FCT_TRANSACTION ADD CONSTRAINT pk_transaction PRIMARY KEY (ID);
    ALTER TABLE IABSA_BRA_REVIEW.DEV.FCT_TRANSACTION ADD CONSTRAINT fk_vendor FOREIGN KEY (VENDOR_ID) REFERENCES IABSA_BRA_REVIEW.DEV.DIM_VENDOR (ID);
    ALTER TABLE IABSA_BRA_REVIEW.DEV.FCT_TRANSACTION ADD CONSTRAINT fk_color FOREIGN KEY (COLOR_ID) REFERENCES IABSA_BRA_REVIEW.DEV.DIM_COLOR (ID);
    ALTER TABLE IABSA_BRA_REVIEW.DEV.FCT_TRANSACTION ADD CONSTRAINT fk_product FOREIGN KEY (PRODUCT_ID) REFERENCES IABSA_BRA_REVIEW.DEV.DIM_PRODUCT (ID);
    ALTER TABLE IABSA_BRA_REVIEW.DEV.FCT_TRANSACTION ADD CONSTRAINT fk_existing_size FOREIGN KEY (EXISTING_SIZE_ID) REFERENCES IABSA_BRA_REVIEW.DEV.DIM_SIZE (ID);
    ALTER TABLE IABSA_BRA_REVIEW.DEV.FCT_TRANSACTION ADD CONSTRAINT fk_available_size FOREIGN KEY (AVAILABLE_SIZE_ID) REFERENCES IABSA_BRA_REVIEW.DEV.DIM_SIZE (ID);
    ALTER TABLE IABSA_BRA_REVIEW.DEV.FCT_TRANSACTION ADD CONSTRAINT fk_product_category FOREIGN KEY (PRODUCT_CATEGORY_ID) REFERENCES IABSA_BRA_REVIEW.DEV.DIM_PRODUCT_CATEGORY (ID);
    ALTER TABLE IABSA_BRA_REVIEW.DEV.FCT_TRANSACTION ADD CONSTRAINT fk_brand FOREIGN KEY (BRAND_ID) REFERENCES IABSA_BRA_REVIEW.DEV.DIM_BRAND (ID);",
)
}}

with src_total_size as
(
    select t.*,
     v.id as vendor_id,
     b.id as brand_id,
     c.id as color_id,
     p.id as product_id,
     pc.id as product_category_id,
     s.id as size_id
    from {{ ref("src_total_size") }} t
    left join {{ ref("dim_vendor") }} v on v.name = t.vendor
    left join {{ ref("dim_brand") }} b on b.name = t.brand
    left join {{ ref("dim_product_category") }} pc on pc.name = t.product_category
    left join {{ ref("dim_color") }} c on c.name = t.color
    left join {{ ref("dim_product") }} p on p.category_id = pc.id and p.name = t.product_name
    left join {{ ref("dim_size") }} s on s.name = t.size
),
src_available_size as
(
    select t.*,
     v.id as vendor_id,
     b.id as brand_id,
     c.id as color_id,
     p.id as product_id,
     pc.id as product_category_id,
     s.id as size_id
    from {{ ref("src_available_size") }} t
    left join {{ ref("dim_vendor") }} v on v.name = t.vendor
    left join {{ ref("dim_brand") }} b on b.name = t.brand
    left join {{ ref("dim_product_category") }} pc on pc.name = t.product_category
    left join {{ ref("dim_color") }} c on c.name = t.color
    left join {{ ref("dim_product") }} p on p.category_id = pc.id and p.name = t.product_name
    left join {{ ref("dim_size") }} s on s.name = t.size
),
fct_transaction_availability as
(
    select 
    t.vendor_id,
    t.brand_id,
    t.product_id,
    t.color_id,
    t.product_category_id,
    t.created_at,
    t.updated_at,
    t.period,
    t.mrp,
    t.rating,
    t.review_count,
    t.size_id as existing_size_id,
    a.size_id as available_size_id,
    case when available_size_id is null then false else true end as is_size_available
    from src_total_size as t
    left join src_available_size as a on
        t.vendor_id = a.vendor_id
        and t.brand_id = a.brand_id
        and t.product_category_id = a.product_category_id
        and t.product_id = a.product_id
        and t.color_id = a.color_id
        --and t.updated_at = a.updated_at
        and t.size_id = a.size_id
        and t.created_at = a.created_at
        --and t.updated_at = a.updated_at
        and t.period = a.period
)

select uuid_string() as id, * from fct_transaction_availability