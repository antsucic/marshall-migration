INSERT INTO staging.facilities
(
    legacy_id
    , legacy_source
    , legacy_company_id
    , legacy_thumbnail_id
    , "name"
    , status
    , created_at
)
SELECT
    products."Id"
    , 'PDM-HRT'
    , companies."Id"
    , products."Thumbnail_File_Id"
    , CASE
        WHEN numbers."Object_Id" IS NULL THEN products."Display_Name"
        ELSE '[' || numbers."Attr_Value" || '] ' || products."Display_Name"
    END
    , products."Status"
    , products."Enter_Date"
FROM
    "PDM-HRT"."Products" products
    JOIN "PDM-HRT"."Owners" owners
        ON products."Owner_Id" = owners."Id"
    JOIN "PDM-HRT"."Companies" companies
        ON owners."Company_Id" = companies."Id"
    JOIN "PDM-HRT"."Attributes" attributes
        ON attributes."Display_Name" = 'Facility ID Number'
    LEFT JOIN "PDM-HRT"."Attribute_Values" numbers
        ON products."Id" = numbers."Object_Id"
        AND attributes."Id" = numbers."Attribute_Id"
;
