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
    , COALESCE(facilities."Id", 'DEFAULT')
    , companies."Id"
    , 'PDM-MNPS'
    , products."Display_Name"
    , products."Description"
    , products."Status"
    , products."Enter_Date"
FROM
    "PDM-MNPS"."Products" products
    JOIN "PDM-MNPS"."Owners" owners
        ON products."Owner_Id" = owners."Id"
    JOIN "PDM-MNPS"."Companies" companies
        ON owners."Company_Id" = companies."Id"
    LEFT JOIN "PDM-MNPS"."Products" facilities
        ON facilities."Display_Name" ~* '^_[^_].*'
        AND products."Display_Name" ~* CONCAT(RTRIM(facilities."Display_Name", '_'), '.*')
;
