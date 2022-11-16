INSERT INTO staging.companies
(
    legacy_id
    , legacy_user_id
    , legacy_location_id
    , "name"
    , phone
    , status
)
SELECT
    owners."Company_Id"
    , entities."Id"
    , entities."Location_Id"
    , owners."Display_Name"
    , owners."Work_Phone"
    , owners."Status"
FROM
    legacy."Owners" owners
    LEFT JOIN legacy."Entities" entities
        ON owners."Email_Address" = entities."Login_Name"
;
