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
    , 'PDM-CCA'
    , companies."Id"
    , products."Thumbnail_File_Id"
    , products."Display_Name"
    , products."Status"
    , products."Enter_Date"
FROM
    "PDM-CCA"."Products" products
    JOIN "PDM-CCA"."Owners" owners
        ON products."Owner_Id" = owners."Id"
    JOIN "PDM-CCA"."Companies" companies
        ON owners."Company_Id" = companies."Id"
;
