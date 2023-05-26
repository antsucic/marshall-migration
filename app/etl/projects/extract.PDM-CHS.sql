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
    , COALESCE(MAX(facilities."Id"), CASE
        WHEN MAX(companies."Display_Name") = 'CHS' THEN 'DEFAULT'
        ELSE MAX(companies."Display_Name") || '_DEFAULT'
    END)
    , 'PDM-CHS'
    , MAX(attributes."Attr_Value")
    , MAX(products."Display_Name")
    , MAX(products."Description")
    , MAX(products."Status")
    , MAX(products."Enter_Date")
FROM
    "PDM-CHS"."Products" products
    LEFT JOIN "PDM-CHS"."Products" facilities
        ON facilities."Display_Name" ~* '^_[^_].*'
        AND products."Display_Name" ~* CONCAT('^', LTRIM(facilities."Display_Name", '_'), '.*')
        AND products."Status" = facilities."Status"
    LEFT JOIN "PDM-CHS"."Attribute_Values" attributes
        ON attributes."Object_Id" = products."Id"
        AND attributes."Attribute_Id" = 'SYS_ATTR4'
    LEFT JOIN "PDM-CHS"."Owners" owners
        ON products."Owner_Id" = owners."Id"
    LEFT JOIN "PDM-CHS"."Companies" companies
        ON owners."Company_Id" = companies."Id"
WHERE
    NOT products."Display_Name" ~* '^_[^_].*'
GROUP BY
    products."Id"
;
