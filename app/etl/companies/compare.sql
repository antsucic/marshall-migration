INSERT INTO transform.companies_production_added
(
    "name"
    , phone
    , status
    , created_at
    , updated_at
    , legacy_ids
    , legacy_source
)
SELECT
    legacy.name
    , legacy.phone
    , legacy.status
    , legacy.created_at
    , legacy.updated_at
    , legacy.legacy_ids
    , legacy.legacy_source
FROM
    transform.companies_legacy legacy
    LEFT JOIN transform.companies_production production
        ON (legacy.name = production.name OR legacy.legacy_ids && production.legacy_ids)
        AND legacy.legacy_source = COALESCE(production.legacy_source, legacy.legacy_source)
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
    , legacy_ids
    , legacy_source
)
SELECT
    production.id
    , legacy.name
    , legacy.phone
    , legacy.status
    , legacy.created_at
    , legacy.updated_at
    , legacy.legacy_ids
    , legacy.legacy_source
FROM
    transform.companies_legacy legacy
    JOIN transform.companies_production production
         ON (legacy.name = production.name OR legacy.legacy_ids && production.legacy_ids)
         AND legacy.legacy_source = COALESCE(production.legacy_source, legacy.legacy_source)
WHERE
    legacy.legacy_ids <> production.legacy_ids
    OR COALESCE(legacy.legacy_source, '') <> COALESCE(production.legacy_source, '')
    OR COALESCE(legacy.name, '') <> COALESCE(production.name, '')
    OR COALESCE(legacy.phone, '') <> COALESCE(production.phone, '')
    OR COALESCE(legacy.status, '') <> COALESCE(production.status, '')
;
