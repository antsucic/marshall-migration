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
    , COALESCE(MAX(facilities."Id"), 'DEFAULT')
    , 'PDM-MNPS'
    , MAX(attributes."Attr_Value")
    , MAX(products."Display_Name")
    , MAX(products."Description")
    , MAX(products."Status")
    , MAX(products."Enter_Date")
FROM
    "PDM-MNPS"."Products" products
    LEFT JOIN "PDM-MNPS"."Products" facilities
        ON facilities."Display_Name" ~* '^_[^_].*'
        AND products."Display_Name" ~* CONCAT('^', LTRIM(facilities."Display_Name", '_'), '.*')
        AND products."Status" = facilities."Status"
    LEFT JOIN "PDM-MNPS"."Attribute_Values" attributes
        ON attributes."Object_Id" = products."Id"
        AND attributes."Attribute_Id" = 'SYS_ATTR4'
WHERE
    NOT products."Display_Name" ~* '^_[^_].*'
GROUP BY
    products."Id"
;
