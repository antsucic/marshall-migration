DROP TABLE IF EXISTS staging.organizations;
DROP TABLE IF EXISTS transform.organizations;
DROP TABLE IF EXISTS transform.organization_aliases;

CREATE TABLE staging.organizations (
    legacy_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , legacy_location_id VARCHAR(36)
    , "name" VARCHAR
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
);

CREATE TABLE transform.organizations (
    id SERIAL PRIMARY KEY
    , "name" VARCHAR
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
);

CREATE TABLE transform.organization_aliases (
    organization_id BIGINT
    , legacy_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , legacy_location_id VARCHAR(36)
);
