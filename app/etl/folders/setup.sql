DROP TABLE IF EXISTS staging.folders;
DROP TABLE IF EXISTS transform.folders_legacy;
DROP TABLE IF EXISTS transform.folders_production;
DROP TABLE IF EXISTS transform.folders_production_added;
DROP TABLE IF EXISTS transform.folders_production_updated;

CREATE TABLE staging.folders (
    legacy_id VARCHAR(36)
    , legacy_folderable_id VARCHAR(36)
    , legacy_parent_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , "name" VARCHAR
    , created_at TIMESTAMP(6)
);

CREATE TABLE transform.folders_legacy (
    legacy_id VARCHAR(36)
    , legacy_folderable_id VARCHAR(36)
    , legacy_parent_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , "name" VARCHAR
    , created_at TIMESTAMP(6) NOT NULL
    , updated_at TIMESTAMP(6) NOT NULL
);

CREATE TABLE transform.folders_production (
    id SERIAL PRIMARY KEY
    , parent_id BIGINT
    , name VARCHAR
    , created_at TIMESTAMP(6) NOT NULL
    , updated_at TIMESTAMP(6) NOT NULL
    , folderable_type VARCHAR
    , folderable_id BIGINT
    , legacy_id VARCHAR(36)
    , legacy_source VARCHAR(100)
);

CREATE TABLE transform.folders_production_added (
    parent_id BIGINT
    , name VARCHAR
    , created_at TIMESTAMP(6) NOT NULL
    , updated_at TIMESTAMP(6) NOT NULL
    , folderable_type VARCHAR
    , folderable_id BIGINT
    , legacy_id VARCHAR(36)
    , legacy_source VARCHAR(100)
);

CREATE TABLE transform.folders_production_updated (
    id SERIAL PRIMARY KEY
    , parent_id BIGINT
    , name VARCHAR
    , updated_at TIMESTAMP(6) NOT NULL
    , folderable_type VARCHAR
    , folderable_id BIGINT
);
