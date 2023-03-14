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
    , 'PDM-HRT'
    , companies."Id"
    , products."Thumbnail_File_Id"
    , products."Id"
    , products."Display_Name"
    , products."Status"
    , products."Enter_Date"
FROM
    "PDM-HRT"."Products" products
    JOIN "PDM-HRT"."Owners" owners
        ON products."Owner_Id" = owners."Id"
    JOIN "PDM-HRT"."Companies" companies
        ON owners."Company_Id" = companies."Id"
;
