DROP TABLE IF EXISTS staging.companies;
DROP TABLE IF EXISTS transform.companies;
DROP TABLE IF EXISTS transform.company_aliases;

CREATE TABLE staging.companies (
    legacy_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , "name" VARCHAR
    , phone VARCHAR
    , status VARCHAR
);

CREATE TABLE transform.companies (
    id SERIAL PRIMARY KEY
    , "name" VARCHAR
    , phone VARCHAR
    , status VARCHAR
    , created_at TIMESTAMP(6) NOT NULL
    , updated_at TIMESTAMP(6) NOT NULL
);

CREATE TABLE transform.company_aliases (
    company_id BIGINT
    , legacy_id VARCHAR(36)
    , legacy_source VARCHAR(100)
);

TRUNCATE TABLE public.companies RESTART IDENTITY CASCADE;

ALTER TABLE public.companies
    ADD COLUMN IF NOT EXISTS legacy_id BIGINT
;
