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
    , 'PDM-Quorum'
    , companies."Id"
    , 'Primary Facility'
    , 2
    , NOW()
FROM
    "PDM-Quorum"."Companies" companies
WHERE
    companies."Display_Name" = 'Quorum Health Corporation'
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
    , 'PDM-Quorum'
    , companies."Id"
    , products."Thumbnail_File_Id"
    , products."Display_Name"
    , products."Status"
    , products."Enter_Date"
FROM
    "PDM-Quorum"."Products" products
    JOIN "PDM-Quorum"."Owners" owners
        ON products."Owner_Id" = owners."Id"
    JOIN "PDM-Quorum"."Companies" companies
        ON owners."Company_Id" = companies."Id"
WHERE
    products."Display_Name" ~* '^_[^_].*'
;
