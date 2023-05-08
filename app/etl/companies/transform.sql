INSERT INTO transform.companies_legacy
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
    "name"
    , MAX(phone)
    , CASE WHEN 2 = ANY(ARRAY_AGG(status::integer)) THEN 'active' ELSE 'inactive' END
    , NOW()
    , NOW()
    , ARRAY_AGG(legacy_id)
    , MAX(legacy_source)
FROM
    staging.companies
GROUP BY
    "name"
;

INSERT INTO transform.companies_production
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
    , production.name
    , production.phone
    , production.status
    , production.created_at
    , production.updated_at
    , production.legacy_ids
    , COALESCE(production.legacy_source, legacy.legacy_source)
FROM
    public.companies production
    LEFT JOIN transform.companies_legacy legacy
        ON production.name = legacy.name
;
