DROP TABLE IF EXISTS staging.facilities;
DROP TABLE IF EXISTS transform.facilities_legacy;
DROP TABLE IF EXISTS transform.facilities_production;
DROP TABLE IF EXISTS transform.facilities_production_added;
DROP TABLE IF EXISTS transform.facilities_production_updated;

CREATE TABLE staging.facilities (
    legacy_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , legacy_company_id VARCHAR(36)
    , legacy_thumbnail_id VARCHAR(36)
    , "name" VARCHAR
    , facility_type VARCHAR
    , status VARCHAR
    , created_at TIMESTAMP
);

CREATE TABLE transform.facilities_legacy (
    legacy_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , legacy_company_id VARCHAR(36)
    , legacy_thumbnail_id VARCHAR(36)
    , "name" VARCHAR
    , facility_type VARCHAR
    , status VARCHAR
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
);

CREATE TABLE transform.facilities_production AS
    SELECT
        id
        , company_id
        , location_id
        , "name"
        , facility_type
        , status
        , created_at
        , updated_at
        , legacy_id
        , legacy_source
    FROM
        public.facilities
;

CREATE TABLE transform.facilities_production_added AS
    SELECT
        company_id
        , location_id
        , "name"
        , facility_type
        , status
        , created_at
        , updated_at
        , legacy_id
        , legacy_source
    FROM
        public.facilities
    WHERE
        FALSE
;

CREATE TABLE transform.facilities_production_updated AS
    SELECT
        id
        , company_id
        , location_id
        , "name"
        , facility_type
        , status
        , updated_at
    FROM
        public.facilities
    WHERE
        FALSE
;
