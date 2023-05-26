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
    , CASE
        WHEN companies."Id" IS NULL THEN 'DEFAULT'
        WHEN products."Id" = 'B3F5C247-BF0B-4BD2-9B8D-912929D9E58F' THEN 'NISSAN_STADIUM'
        ELSE companies."Id"
    END
    , products."Thumbnail_File_Id"
    , products."Display_Name"
    , products."Status"
    , products."Enter_Date"
FROM
    "PDM-DEMO"."Products" products
    LEFT JOIN "PDM-DEMO"."Owners" owners
        ON products."Owner_Id" = owners."Id"
    LEFT JOIN "PDM-DEMO"."Companies" companies
        ON owners."Company_Id" = companies."Id"
;
