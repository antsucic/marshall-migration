DROP TABLE IF EXISTS staging.projects;
DROP TABLE IF EXISTS transform.projects_legacy;
DROP TABLE IF EXISTS transform.projects_production;
DROP TABLE IF EXISTS transform.projects_production_added;
DROP TABLE IF EXISTS transform.projects_production_updated;

CREATE TABLE staging.projects (
    legacy_id VARCHAR(36)
    , legacy_facility_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , "name" VARCHAR
    , number VARCHAR
    , description VARCHAR
    , discipline VARCHAR
    , status VARCHAR
    , created_at TIMESTAMP
);

CREATE TABLE transform.projects_legacy (
    legacy_id VARCHAR(36)
    , legacy_facility_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , "name" VARCHAR
    , number VARCHAR
    , description VARCHAR
    , discipline VARCHAR
    , status VARCHAR
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
);

CREATE TABLE transform.projects_production (
    id SERIAL PRIMARY KEY
    , facility_id BIGINT
    , "name" VARCHAR
    , number VARCHAR
    , description VARCHAR
    , discipline VARCHAR
    , status VARCHAR
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
    , legacy_id VARCHAR(36)
    , legacy_source VARCHAR(100)
);

CREATE TABLE transform.projects_production_added (
    "name" VARCHAR
    , facility_id BIGINT
    , number VARCHAR
    , description VARCHAR
    , discipline VARCHAR
    , status VARCHAR
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
    , legacy_id VARCHAR(36)
    , legacy_source VARCHAR(100)
);

CREATE TABLE transform.projects_production_updated (
    id SERIAL PRIMARY KEY
    , facility_id BIGINT
    , "name" VARCHAR
    , number VARCHAR
    , description VARCHAR
    , discipline VARCHAR
    , status VARCHAR
    , updated_at TIMESTAMP
);
