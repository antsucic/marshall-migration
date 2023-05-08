INSERT INTO transform.organizations_production_added
(
    name
    , created_at
    , updated_at
    , legacy_ids
)
SELECT
    legacy.name
    , legacy.created_at
    , legacy.updated_at
    , legacy.legacy_ids
FROM
    transform.organizations_legacy legacy
    LEFT JOIN transform.organizations_production production
        ON legacy.name = production.name
WHERE
    production.id IS NULL
;

INSERT INTO transform.organizations_production_updated
(
    id
    , name
    , updated_at
    , legacy_ids
)
SELECT
    production.id
     , legacy.name
     , legacy.updated_at
     , legacy.legacy_ids
FROM
    transform.organizations_legacy legacy
    JOIN transform.organizations_production production
         ON legacy.name = production.name
WHERE
    COALESCE(legacy.name, '') <> COALESCE(production.name, '')
    OR COALESCE(legacy.legacy_ids::VARCHAR, '') <> COALESCE(production.legacy_ids::VARCHAR, '')
;
