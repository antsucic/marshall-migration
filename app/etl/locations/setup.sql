DROP TABLE IF EXISTS staging.locations;
DROP TABLE IF EXISTS transform.locations;

CREATE TABLE staging.locations (
    legacy_id VARCHAR(36)
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
    , address VARCHAR
    , city VARCHAR
    , state VARCHAR
    , country VARCHAR
    , postal_code VARCHAR
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
);

TRUNCATE TABLE public.locations RESTART IDENTITY CASCADE;

ALTER TABLE public.locations
    ADD COLUMN IF NOT EXISTS legacy_id VARCHAR(36)
;
