DROP TABLE IF EXISTS staging.users;
DROP TABLE IF EXISTS transform.users;

CREATE TABLE staging.users (
    legacy_id VARCHAR
    , email VARCHAR
    , first_name VARCHAR
    , last_name VARCHAR
    , status VARCHAR
    , parent_entity_id VARCHAR
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
);

CREATE TABLE transform.users (
    legacy_id VARCHAR(36)
    , email VARCHAR
    , first_name VARCHAR
    , last_name VARCHAR
    , status VARCHAR
    , "role" VARCHAR
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
);

TRUNCATE TABLE public.users RESTART IDENTITY CASCADE;

ALTER TABLE public.users
    ADD COLUMN IF NOT EXISTS legacy_id VARCHAR(36)
;
