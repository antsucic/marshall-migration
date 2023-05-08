DROP TABLE IF EXISTS staging.entities;
DROP TABLE IF EXISTS staging.owners;
DROP TABLE IF EXISTS transform.users_legacy;
DROP TABLE IF EXISTS transform.users_production;
DROP TABLE IF EXISTS transform.users_production_added;
DROP TABLE IF EXISTS transform.users_production_updated;

CREATE TABLE staging.entities (
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

CREATE TABLE transform.users_legacy (
    legacy_ids JSONB
    , email VARCHAR
    , first_name VARCHAR
    , last_name VARCHAR
    , status VARCHAR
    , "role" VARCHAR
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
);

CREATE TABLE transform.users_production (
    id SERIAL PRIMARY KEY
    , email VARCHAR
    , first_name VARCHAR
    , last_name VARCHAR
    , status VARCHAR
    , "role" VARCHAR
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
    , legacy_ids JSONB
);

CREATE TABLE transform.users_production_added (
    email VARCHAR
    , first_name VARCHAR
    , last_name VARCHAR
    , status VARCHAR
    , "role" VARCHAR
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
    , legacy_ids JSONB
);

CREATE TABLE transform.users_production_updated (
    id SERIAL PRIMARY KEY
    , email VARCHAR
    , first_name VARCHAR
    , last_name VARCHAR
    , status VARCHAR
    , "role" VARCHAR
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
    , legacy_ids JSONB
);
