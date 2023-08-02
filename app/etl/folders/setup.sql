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
    , status VARCHAR
    , created_at TIMESTAMP(6)
);

CREATE TABLE transform.folders_legacy (
    legacy_id VARCHAR(36)
    , legacy_folderable_id VARCHAR(36)
    , legacy_parent_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , "name" VARCHAR
    , hidden BOOLEAN
    , created_at TIMESTAMP(6) NOT NULL
    , updated_at TIMESTAMP(6) NOT NULL
);

CREATE INDEX ON transform.folders_legacy (legacy_id);
CREATE INDEX ON transform.folders_legacy (legacy_folderable_id);
CREATE INDEX ON transform.folders_legacy (legacy_parent_id);
CREATE INDEX ON transform.folders_legacy (legacy_source);

CREATE TABLE transform.folders_production (
    id BIGINT
    , parent_id BIGINT
    , name VARCHAR
    , hidden BOOLEAN
    , created_at TIMESTAMP(6) NOT NULL
    , updated_at TIMESTAMP(6) NOT NULL
    , folderable_type VARCHAR
    , folderable_id BIGINT
    , legacy_id VARCHAR(36)
    , legacy_source VARCHAR(100)
);

CREATE INDEX ON transform.folders_production (legacy_id);
CREATE INDEX ON transform.folders_production (legacy_source);

CREATE TABLE transform.folders_production_added (
    parent_id BIGINT
    , name VARCHAR
    , hidden BOOLEAN
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
    , hidden BOOLEAN
    , updated_at TIMESTAMP(6) NOT NULL
    , folderable_type VARCHAR
    , folderable_id BIGINT
);
