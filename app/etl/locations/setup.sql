DROP TABLE IF EXISTS staging.locations;
DROP TABLE IF EXISTS transform.locations_legacy;
DROP TABLE IF EXISTS transform.locations_production;
DROP TABLE IF EXISTS transform.locations_production_added;
DROP TABLE IF EXISTS transform.locations_production_updated;

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

CREATE TABLE transform.locations_legacy (
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

CREATE TABLE transform.locations_production AS
    SELECT
        id
        , address
        , city
        , state
        , country
        , postal_code
        , created_at
        , updated_at
        , legacy_id
        , legacy_facility_id
        , legacy_source
    FROM
        public.locations
;

CREATE TABLE transform.locations_production_added AS
    SELECT
        address
        , city
        , state
        , country
        , postal_code
        , created_at
        , updated_at
        , legacy_id
        , legacy_facility_id
        , legacy_source
    FROM
        public.locations
    WHERE
        FALSE
;

CREATE TABLE transform.locations_production_updated AS
    SELECT
        id
        , address
        , city
        , state
        , country
        , postal_code
        , updated_at
        , legacy_facility_id
    FROM
        public.locations
    WHERE
        FALSE
;
