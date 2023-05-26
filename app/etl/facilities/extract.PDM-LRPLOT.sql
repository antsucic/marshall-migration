WITH additional_companies AS (
    SELECT
        products."Id" product_id
        , REGEXP_REPLACE(UPPER(companies."Attr_Value"), '[\W\s]+', '_', 'g') company_id
    FROM
        "PDM-LRPLOT"."Attribute_Values" companies
        JOIN "PDM-LRPLOT"."Products" products
            ON companies."Object_Id" = products."Id"
    WHERE
        companies."Attribute_Id" = 'SYS_ATTR434'
)
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
    , 'PDM-LRPLOT'
    , COALESCE(additional_companies.company_id, companies."Id")
    , products."Thumbnail_File_Id"
    , products."Display_Name"
    , products."Status"
    , products."Enter_Date"
FROM
    "PDM-LRPLOT"."Products" products
    JOIN "PDM-LRPLOT"."Owners" owners
        ON products."Owner_Id" = owners."Id"
    JOIN "PDM-LRPLOT"."Companies" companies
        ON owners."Company_Id" = companies."Id"
    LEFT JOIN additional_companies
        ON products."Id" = additional_companies.product_id
;
