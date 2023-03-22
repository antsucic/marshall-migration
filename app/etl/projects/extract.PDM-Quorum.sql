INSERT INTO staging.projects
(
    legacy_id
    , legacy_facility_id
    , legacy_company_id
    , legacy_source
    , number
    , "name"
    , description
    , status
    , created_at
)
SELECT
    products."Id"
    , COALESCE(facilities."Id", 'DEFAULT')
    , companies."Id"
    , 'PDM-Quorum'
    , attributes."Attr_Value"
    , products."Display_Name"
    , products."Description"
    , products."Status"
    , products."Enter_Date"
FROM
    "PDM-Quorum"."Products" products
    JOIN "PDM-Quorum"."Owners" owners
        ON products."Owner_Id" = owners."Id"
    JOIN "PDM-Quorum"."Companies" companies
        ON owners."Company_Id" = companies."Id"
    LEFT JOIN "PDM-Quorum"."Products" facilities
        ON facilities."Display_Name" ~* '^_[^_].*'
        AND products."Display_Name" ~* CONCAT(RTRIM(facilities."Display_Name", '_'), '.*')
    LEFT JOIN "PDM-Quorum"."Attribute_Values" attributes
        ON attributes."Object_Id" = products."Id"
        AND attributes."Attribute_Id" = 'SYS_ATTR4'
;
