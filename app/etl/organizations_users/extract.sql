INSERT INTO staging.organizations_users
(
    legacy_organization_id
    , legacy_user_id
    , phone
    , mobile_phone
    , legacy_location_id
)
SELECT
    entities."Organization_Id"
    , entities."Id"
    , entities."Work_Phone"
    , entities."Cell_Phone"
    , entities."Location_Id"
FROM
    legacy."Entities" entities
;
