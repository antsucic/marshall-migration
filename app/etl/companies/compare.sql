INSERT INTO transform.companies_production_added
(
    "name"
    , phone
    , status
    , created_at
    , updated_at
    , legacy_sources
)
SELECT
    legacy.name
    , legacy.phone
    , legacy.status
    , legacy.created_at
    , legacy.updated_at
    , legacy.legacy_sources
FROM
    transform.companies_legacy legacy
    LEFT JOIN transform.companies_production production
        ON legacy.name = production.name
WHERE
    production.id IS NULL
;

INSERT INTO transform.companies_production_updated
(
    id
    , "name"
    , phone
    , status
    , created_at
    , updated_at
    , legacy_sources
)
SELECT
    production.id
    , legacy.name
    , legacy.phone
    , legacy.status
    , legacy.created_at
    , legacy.updated_at
    , legacy.legacy_sources
FROM
    transform.companies_legacy legacy
    JOIN transform.companies_production production
         ON legacy.name = production.name
WHERE
    legacy.legacy_sources <> production.legacy_sources
    OR COALESCE(legacy.name, '') <> COALESCE(production.name, '')
    OR COALESCE(legacy.phone, '') <> COALESCE(production.phone, '')
    OR COALESCE(legacy.status, '') <> COALESCE(production.status, '')
;
