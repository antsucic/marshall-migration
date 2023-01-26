DROP TABLE IF EXISTS staging.companies;
DROP TABLE IF EXISTS transform.companies;

CREATE TABLE staging.companies (
    legacy_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , legacy_user_id VARCHAR(36)
    , legacy_location_id VARCHAR(36)
    , "name" VARCHAR
    , phone VARCHAR
    , status VARCHAR
);

CREATE TABLE transform.companies (
    legacy_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , legacy_user_id VARCHAR(36)
    , legacy_location_id VARCHAR(36)
    , "name" VARCHAR
    , phone VARCHAR
    , status VARCHAR
    , created_at TIMESTAMP(6) NOT NULL
    , updated_at TIMESTAMP(6) NOT NULL
);

TRUNCATE TABLE public.companies RESTART IDENTITY CASCADE;

ALTER TABLE public.companies
    ADD COLUMN IF NOT EXISTS legacy_id VARCHAR(36)
    , ADD COLUMN IF NOT EXISTS legacy_source VARCHAR(100)
    , ADD COLUMN IF NOT EXISTS legacy_user_id VARCHAR(36)
    , ADD COLUMN IF NOT EXISTS legacy_location_id VARCHAR(36)
;
