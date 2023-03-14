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
    , 'DEFAULT'
    , companies."Id"
    , 'PDM-ESA'
    , av."Attr_Value"
    , products."Display_Name"
    , products."Description"
    , products."Status"
    , products."Enter_Date"
FROM
    "PDM-ESA"."Products" products
    JOIN "PDM-ESA"."Owners" owners
        ON products."Owner_Id" = owners."Id"
    JOIN "PDM-ESA"."Companies" companies
        ON owners."Company_Id" = companies."Id"
    LEFT JOIN "PDM-ESA"."Attribute_Values" av
        ON av."Object_Id" = products."Id"
        AND av."Attribute_Id" = 'SYS_ATTR4'
;
