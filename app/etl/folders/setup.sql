DROP TABLE IF EXISTS staging.folders;
DROP TABLE IF EXISTS transform.folders;

CREATE TABLE staging.folders (
    legacy_id VARCHAR(36)
    , legacy_folderable_id VARCHAR(36)
    , legacy_parent_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , "name" VARCHAR
    , created_at TIMESTAMP(6)
);

CREATE TABLE transform.folders (
    legacy_id VARCHAR(36)
    , legacy_folderable_id VARCHAR(36)
    , legacy_parent_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , "name" VARCHAR
    , created_at TIMESTAMP(6) NOT NULL
    , updated_at TIMESTAMP(6) NOT NULL
);
