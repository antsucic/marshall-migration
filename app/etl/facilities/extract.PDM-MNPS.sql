INSERT INTO staging.facilities
(
    legacy_id
    , legacy_source
    , legacy_company_id
    , legacy_location_id
    , "name"
    , status
    , created_at
)
SELECT
    'DEFAULT'
    , 'PDM-MNPS'
    , companies."Id"
    , companies."Id"
    , 'Primary Facility'
    , 2
    , NOW()
FROM
    "PDM-MNPS"."Companies" companies
WHERE
    companies."Display_Name" = 'Metro Nashville Public Schools'
;

INSERT INTO staging.facilities
(
    legacy_id
    , legacy_source
    , legacy_company_id
    , legacy_location_id
    , legacy_thumbnail_id
    , "name"
    , status
    , created_at
)
SELECT
    products."Id"
    , 'PDM-MNPS'
    , companies."Id"
    , products."Id"
    , products."Thumbnail_File_Id"
    , products."Display_Name"
    , products."Status"
    , products."Enter_Date"
FROM
    "PDM-MNPS"."Products" products
    JOIN "PDM-MNPS"."Owners" owners
        ON products."Owner_Id" = owners."Id"
    JOIN "PDM-MNPS"."Companies" companies
        ON owners."Company_Id" = companies."Id"
WHERE
    products."Display_Name" ~* '^_[^_].*'
;
