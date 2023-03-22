DROP TABLE IF EXISTS staging.facilities;
DROP TABLE IF EXISTS transform.facilities;

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

CREATE TABLE transform.facilities (
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

TRUNCATE TABLE public.facilities RESTART IDENTITY CASCADE;

ALTER TABLE public.facilities
    ADD COLUMN IF NOT EXISTS legacy_id VARCHAR(36)
    , ADD COLUMN IF NOT EXISTS legacy_source VARCHAR(100)
;
