INSERT INTO transform.projects_production_added
(
    facility_id
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
    facilities.id
    , legacy.name
    , legacy.number
    , legacy.description
    , legacy.status
    , legacy.created_at
    , legacy.updated_at
    , legacy.legacy_id
    , legacy.legacy_source
FROM
    transform.projects_legacy legacy
    LEFT JOIN public.facilities facilities
        ON legacy.legacy_facility_id = facilities.legacy_id
        AND legacy.legacy_source = facilities.legacy_source
    LEFT JOIN transform.projects_production production
        ON legacy.legacy_id = production.legacy_id
        AND legacy.legacy_source = production.legacy_source
WHERE
    production.id IS NULL
;

INSERT INTO transform.projects_production_updated
(
    id
    , facility_id
    , "name"
    , number
    , description
    , status
    , updated_at
)
SELECT
    production.id
    , facilities.id
    , legacy.name
    , legacy.number
    , legacy.description
    , legacy.status
    , legacy.updated_at
FROM
    transform.projects_legacy legacy
    JOIN transform.projects_production production
         ON legacy.legacy_id = production.legacy_id
         AND legacy.legacy_source = production.legacy_source
    JOIN public.facilities facilities
        ON legacy.legacy_facility_id = facilities.legacy_id
        AND legacy.legacy_source = facilities.legacy_source
WHERE
    COALESCE(legacy.name, '') <> COALESCE(production.name, '')
    OR COALESCE(legacy.number, '') <> COALESCE(production.number, '')
    OR COALESCE(legacy.description, '') <> COALESCE(production.description, '')
    OR COALESCE(legacy.status, '') <> COALESCE(production.status, '')
;
