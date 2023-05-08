INSERT INTO transform.projects_legacy
(
    legacy_id
    , legacy_source
    , legacy_facility_id
    , "name"
    , number
    , description
    , status
    , created_at
    , updated_at
)
SELECT
    legacy_id
    , legacy_source
    , legacy_facility_id
    , "name"
    , number
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

INSERT INTO transform.projects_production
(
    id
    , facility_id
    , "name"
    , number
    , description
    , status
    , created_at
    , updated_at
    , legacy_id
    , legacy_source
)
SELECT
    MIN(id)
    , MAX(facility_id)
    , MAX("name")
    , MAX(number)
    , MAX(description)
    , MAX(status)
    , MAX(created_at)
    , MAX(updated_at)
    , legacy_id
    , legacy_source
FROM
    public.projects
GROUP BY
    legacy_id
    , legacy_source
;
