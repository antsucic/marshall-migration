INSERT INTO staging.projects
(
    legacy_id
    , legacy_facility_id
    , legacy_source
    , number
    , "name"
    , description
    , status
    , created_at
)
SELECT
    products."Id"
    , 'DEFAULT'
    , 'PDM-BWSC'
    , attributes."Attr_Value"
    , products."Display_Name"
    , products."Description"
    , products."Status"
    , products."Enter_Date"
FROM
    "PDM-BWSC"."Products" products
    LEFT JOIN "PDM-BWSC"."Attribute_Values" attributes
        ON attributes."Object_Id" = products."Id"
       AND attributes."Attribute_Id" = 'SYS_ATTR4'
;
