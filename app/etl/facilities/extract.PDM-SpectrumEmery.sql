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
    , 'PDM-SpectrumEmery'
    , companies."Id"
    , products."Id"
    , products."Thumbnail_File_Id"
    , products."Display_Name"
    , products."Status"
    , products."Enter_Date"
FROM
    "PDM-SpectrumEmery"."Products" products
    JOIN "PDM-SpectrumEmery"."Owners" owners
        ON products."Owner_Id" = owners."Id"
    JOIN "PDM-SpectrumEmery"."Companies" companies
        ON owners."Company_Id" = companies."Id"
;
