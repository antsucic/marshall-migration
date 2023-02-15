INSERT INTO staging.facilities
(
    legacy_id
    , legacy_source
    , legacy_company_id
    , "name"
    , status
    , created_at
)
SELECT
    'DEFAULT'
    , 'PDM-DEMO'
    , companies."Id"
    , 'Primary Facility'
    , 2
    , NOW()
FROM
    "PDM-DEMO"."Companies" companies
WHERE
    companies."Display_Name" = 'MBA'
;

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
    , 'PDM-DEMO'
    , companies."Id"
    , products."Thumbnail_File_Id"
    , products."Display_Name"
    , products."Status"
    , products."Enter_Date"
FROM
    "PDM-DEMO"."Products" products
    JOIN "PDM-DEMO"."Owners" owners
        ON products."Owner_Id" = owners."Id"
    JOIN "PDM-DEMO"."Companies" companies
        ON owners."Company_Id" = companies."Id"
;
