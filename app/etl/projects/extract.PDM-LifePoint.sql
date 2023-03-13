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
    , 'PDM-LifePoint'
    , products."Display_Name"
    , products."Description"
    , products."Status"
    , products."Enter_Date"
FROM
    "PDM-LifePoint"."Products" products
    JOIN "PDM-LifePoint"."Owners" owners
        ON products."Owner_Id" = owners."Id"
    JOIN "PDM-LifePoint"."Companies" companies
        ON owners."Company_Id" = companies."Id"
    LEFT JOIN "PDM-LifePoint"."Products" facilities
        ON facilities."Display_Name" ~* '^_[^_].*'
        AND products."Display_Name" ~* CONCAT(RTRIM(facilities."Display_Name", '_'), '.*')
;