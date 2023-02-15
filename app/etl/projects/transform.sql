INSERT INTO transform.projects
(
    legacy_id
    , legacy_source
    , legacy_facility_id
    , legacy_company_id
    , "name"
    , description
    , status
    , created_at
    , updated_at
)
SELECT
    legacy_id
    , legacy_source
    , legacy_facility_id
    , legacy_company_id
    , "name"
    , description
    , CASE status
        WHEN '2' THEN 'active'
        ELSE 'inactive'
    END
    , created_at
    , created_at
FROM
    staging.projects
;
