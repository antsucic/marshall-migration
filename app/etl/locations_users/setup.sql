TRUNCATE TABLE public.locations_users RESTART IDENTITY CASCADE;

DROP TABLE IF EXISTS staging.locations_users;

CREATE TABLE staging.locations_users (
    legacy_user_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , legacy_location_id VARCHAR(36)
);
