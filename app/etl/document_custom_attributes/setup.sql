DROP TABLE IF EXISTS staging.document_custom_attributes;
DROP TABLE IF EXISTS transform.document_custom_attributes_legacy;
DROP TABLE IF EXISTS transform.document_custom_attributes_production;
DROP TABLE IF EXISTS transform.document_custom_attributes_production_added;

CREATE TABLE staging.document_custom_attributes (
    legacy_id VARCHAR(36)
    , legacy_company_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , "name" VARCHAR
);

CREATE TABLE transform.document_custom_attributes_legacy AS
    SELECT
        legacy_id
        , legacy_id AS legacy_company_id
        , legacy_source
        , "name"
        , document_type
        , is_required
        , is_deleted
        , created_at
    FROM
        public.document_custom_attributes
    WHERE
        FALSE
;

CREATE TABLE transform.document_custom_attributes_production AS
    SELECT
        id
        , company_id
        , "name"
        , document_type
        , is_required
        , is_deleted
        , created_at
        , updated_at
        , legacy_id
        , legacy_source
    FROM
        public.document_custom_attributes
;

CREATE TABLE transform.document_custom_attributes_production_added AS
    SELECT
        company_id
        , "name"
        , document_type
        , is_required
        , is_deleted
        , created_at
        , updated_at
        , legacy_id
        , legacy_source
    FROM
        public.document_custom_attributes
    WHERE
        FALSE
;
