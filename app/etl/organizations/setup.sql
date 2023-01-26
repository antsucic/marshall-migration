DROP TABLE IF EXISTS staging.organizations;
DROP TABLE IF EXISTS transform.organizations;

CREATE TABLE staging.organizations (
    legacy_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , legacy_location_id VARCHAR(36)
    , "name" VARCHAR
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
);

CREATE TABLE transform.organizations (
    legacy_ids VARCHAR
    , legacy_source VARCHAR(100)
    , legacy_location_ids VARCHAR
    , "name" VARCHAR
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
);

TRUNCATE TABLE public.organizations RESTART IDENTITY CASCADE;

ALTER TABLE public.organizations
    ADD COLUMN IF NOT EXISTS legacy_ids VARCHAR
    , ADD COLUMN IF NOT EXISTS legacy_location_ids VARCHAR
;
