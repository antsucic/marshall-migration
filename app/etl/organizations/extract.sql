INSERT INTO staging.organizations
(
    legacy_id
    , legacy_location_id
    , "name"
    , created_at
    , updated_at
)
SELECT
    organizations."Id"
    , organizations."Location_Id"
    , organizations."Display_Name"
    , organizations."Last_Edit_DateTime"
    , organizations."Last_Edit_DateTime"
FROM
    legacy."Organizations" organizations
;
