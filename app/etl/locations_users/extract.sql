INSERT INTO staging.locations_users
(
    legacy_location_id
    , legacy_user_id
)
SELECT
    entities."Location_Id"
    , entities."Id"
FROM
    legacy."Entities" entities
;
