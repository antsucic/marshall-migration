DROP TABLE IF EXISTS staging.organizations_users;

CREATE TABLE staging.organizations_users (
    legacy_organization_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , legacy_user_id VARCHAR(36)
    , phone VARCHAR
    , mobile_phone VARCHAR
    , legacy_location_id VARCHAR(36)
);
