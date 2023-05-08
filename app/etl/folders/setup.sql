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

CREATE INDEX ON transform.folders_legacy (legacy_id);
CREATE INDEX ON transform.folders_legacy (legacy_folderable_id);
CREATE INDEX ON transform.folders_legacy (legacy_parent_id);
CREATE INDEX ON transform.folders_legacy (legacy_source);

CREATE TABLE transform.folders_production (
    id BIGINT
    , parent_id BIGINT
    , name VARCHAR
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

CREATE INDEX IF NOT EXISTS index_facilities_legacy_id ON public.facilities (legacy_id);
CREATE INDEX IF NOT EXISTS index_facilities_legacy_source ON public.facilities (legacy_source);
CREATE INDEX IF NOT EXISTS index_projects_legacy_id ON public.projects (legacy_id);
CREATE INDEX IF NOT EXISTS index_projects_legacy_source ON public.projects (legacy_source);
CREATE INDEX IF NOT EXISTS index_folders_legacy_id ON public.folders (legacy_id);
CREATE INDEX IF NOT EXISTS index_folders_legacy_source ON public.folders (legacy_source);
