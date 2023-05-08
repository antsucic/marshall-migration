DROP TABLE IF EXISTS staging.organizations;
DROP TABLE IF EXISTS transform.organizations_legacy;
DROP TABLE IF EXISTS transform.organizations_production;
DROP TABLE IF EXISTS transform.organizations_production_added;
DROP TABLE IF EXISTS transform.organizations_production_updated;

CREATE TABLE staging.organizations (
    legacy_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , legacy_location_id VARCHAR(36)
    , "name" VARCHAR
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
);

CREATE TABLE transform.organizations_legacy (
    legacy_ids JSONB
    , "name" VARCHAR
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
);

CREATE TABLE transform.organizations_production (
    id SERIAL PRIMARY KEY
    , "name" VARCHAR
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
    , legacy_ids JSONB
);

CREATE TABLE transform.organizations_production_added (
    "name" VARCHAR
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
    , legacy_ids JSONB
);

CREATE TABLE transform.organizations_production_updated (
    id SERIAL PRIMARY KEY
    , "name" VARCHAR
    , updated_at TIMESTAMP
    , legacy_ids JSONB
);
