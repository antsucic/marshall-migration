DROP TABLE IF EXISTS staging.locations;
DROP TABLE IF EXISTS transform.locations;

CREATE TABLE staging.locations (
    legacy_id VARCHAR(36)
    , legacy_facility_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , address_1 VARCHAR
    , address_2 VARCHAR
    , city VARCHAR
    , region VARCHAR
    , postal_code VARCHAR
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
);

CREATE TABLE transform.locations (
    legacy_id VARCHAR(36)
    , legacy_facility_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , address VARCHAR
    , city VARCHAR
    , state VARCHAR
    , country VARCHAR
    , postal_code VARCHAR
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
);
