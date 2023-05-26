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
    CASE
        WHEN companies."Display_Name" = 'CHS' THEN 'DEFAULT'
        ELSE companies."Display_Name" || '_DEFAULT'
    END
    , 'PDM-CHS'
    , companies."Id"
    , 'Primary Facility'
    , 2
    , NOW()
FROM
    "PDM-CHS"."Companies" companies
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
    , 'PDM-CHS'
    , companies."Id"
    , products."Thumbnail_File_Id"
    , products."Display_Name"
    , products."Status"
    , products."Enter_Date"
FROM
    "PDM-CHS"."Products" products
    JOIN "PDM-CHS"."Owners" owners
        ON products."Owner_Id" = owners."Id"
    JOIN "PDM-CHS"."Companies" companies
        ON owners."Company_Id" = companies."Id"
WHERE
    products."Display_Name" ~* '^_[^_].*'
;
