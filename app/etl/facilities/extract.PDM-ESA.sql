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
    , 'PDM-ESA'
    , companies."Id"
    , companies."Id"
    , 'Primary Facility'
    , 2
    , NOW()
FROM
    "PDM-ESA"."Companies" companies
WHERE
    companies."Display_Name" = 'ESa'
;
