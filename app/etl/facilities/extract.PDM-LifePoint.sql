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
    , 'PDM-LifePoint'
    , companies."Id"
    , companies."Id"
    , 'Primary Facility'
    , 2
    , NOW()
FROM
    "PDM-LifePoint"."Companies" companies
WHERE
    companies."Display_Name" = 'Lifepoint Hospitals'
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
    , 'PDM-LifePoint'
    , companies."Id"
    , products."Id"
    , products."Thumbnail_File_Id"
    , products."Display_Name"
    , products."Status"
    , products."Enter_Date"
FROM
    "PDM-LifePoint"."Products" products
    JOIN "PDM-LifePoint"."Owners" owners
        ON products."Owner_Id" = owners."Id"
    JOIN "PDM-LifePoint"."Companies" companies
        ON owners."Company_Id" = companies."Id"
WHERE
    products."Display_Name" ~* '^_[^_].*'
;
