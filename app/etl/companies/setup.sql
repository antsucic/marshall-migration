DROP TABLE IF EXISTS staging.companies;
DROP TABLE IF EXISTS transform.companies_legacy;
DROP TABLE IF EXISTS transform.companies_production;
DROP TABLE IF EXISTS transform.companies_production_added;
DROP TABLE IF EXISTS transform.companies_production_updated;

CREATE TABLE staging.companies (
    legacy_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , "name" VARCHAR
    , phone VARCHAR
    , status VARCHAR
);

CREATE TABLE transform.companies_legacy (
    legacy_sources JSONB
    , "name" VARCHAR
    , phone VARCHAR
    , status VARCHAR
    , created_at TIMESTAMP(6) NOT NULL
    , updated_at TIMESTAMP(6) NOT NULL
);

CREATE TABLE transform.companies_production (
    id SERIAL PRIMARY KEY
    , "name" VARCHAR
    , phone VARCHAR
    , status VARCHAR
    , created_at TIMESTAMP(6) NOT NULL
    , updated_at TIMESTAMP(6) NOT NULL
    , legacy_sources JSONB
);

CREATE TABLE transform.companies_production_added (
    legacy_sources JSONB
    , "name" VARCHAR
    , phone VARCHAR
    , status VARCHAR
    , created_at TIMESTAMP(6) NOT NULL
    , updated_at TIMESTAMP(6) NOT NULL
);

CREATE TABLE transform.companies_production_updated (
    id SERIAL PRIMARY KEY
    , legacy_sources JSONB
    , "name" VARCHAR
    , phone VARCHAR
    , status VARCHAR
    , created_at TIMESTAMP(6) NOT NULL
    , updated_at TIMESTAMP(6) NOT NULL
);
