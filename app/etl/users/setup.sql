DROP TABLE IF EXISTS staging.users;
DROP TABLE IF EXISTS transform.users;
DROP TABLE IF EXISTS transform.user_aliases;

CREATE TABLE staging.users (
    legacy_id VARCHAR
    , legacy_source VARCHAR(100)
    , email VARCHAR
    , first_name VARCHAR
    , last_name VARCHAR
    , status VARCHAR
    , parent_entity_id VARCHAR
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
);

CREATE TABLE staging.owners (
    legacy_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , legacy_company_id VARCHAR(36)
    , email VARCHAR
    , first_name VARCHAR
    , last_name VARCHAR
    , status VARCHAR
);

CREATE TABLE transform.users (
    id SERIAL PRIMARY KEY
    , legacy_company_id VARCHAR(36)
    , email VARCHAR
    , first_name VARCHAR
    , last_name VARCHAR
    , status VARCHAR
    , "role" VARCHAR
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
);

CREATE TABLE transform.user_aliases (
    user_id BIGINT
    , legacy_id VARCHAR(36)
    , legacy_source VARCHAR(100)
);

TRUNCATE TABLE public.users RESTART IDENTITY CASCADE;

ALTER TABLE public.users
    ADD COLUMN IF NOT EXISTS legacy_id BIGINT
;
