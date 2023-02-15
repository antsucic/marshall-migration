INSERT INTO staging.projects
(
    legacy_id
    , legacy_facility_id
    , legacy_company_id
    , legacy_source
    , "name"
    , description
    , status
    , created_at
)
SELECT
    products."Id"
    , 'DEFAULT'
    , companies."Id"
    , 'PDM-ESA'
    , products."Display_Name"
    , products."Description"
    , products."Status"
    , products."Enter_Date"
FROM
    "PDM-ESA"."Products" products
    JOIN "PDM-ESA"."Owners" owners
        ON products."Owner_Id" = owners."Id"
    JOIN "PDM-ESA"."Companies" companies
        ON owners."Company_Id" = companies."Id"
;
