DROP TABLE IF EXISTS staging.projects;
DROP TABLE IF EXISTS transform.projects;

CREATE TABLE staging.projects (
    legacy_id VARCHAR(36)
    , legacy_company_id VARCHAR(36)
    , legacy_facility_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , "name" VARCHAR
    , number VARCHAR
    , description VARCHAR
    , discipline VARCHAR
    , status VARCHAR
    , created_at TIMESTAMP
);

CREATE TABLE transform.projects (
    legacy_id VARCHAR(36)
    , legacy_company_id VARCHAR(36)
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
