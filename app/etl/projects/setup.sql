DROP TABLE IF EXISTS staging.projects;
DROP TABLE IF EXISTS transform.projects;

CREATE TABLE staging.projects (
    legacy_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , legacy_facility_id VARCHAR(36)
    , "name" VARCHAR
    , number VARCHAR
    , description VARCHAR
    , discipline VARCHAR
    , status VARCHAR
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
);

CREATE TABLE transform.projects (
    legacy_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , legacy_facility_id VARCHAR(36)
    , "name" VARCHAR
    , number VARCHAR
    , description VARCHAR
    , discipline VARCHAR
    , status VARCHAR
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
);

TRUNCATE TABLE public.projects RESTART IDENTITY CASCADE;

ALTER TABLE public.projects
    ADD COLUMN IF NOT EXISTS legacy_id VARCHAR(36)
    , ADD COLUMN IF NOT EXISTS legacy_source VARCHAR(100)
;
