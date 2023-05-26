INSERT INTO transform.companies_legacy
(
    "name"
    , phone
    , status
    , created_at
    , updated_at
    , legacy_sources
)
SELECT
    "name"
    , MAX(phone)
    , CASE WHEN 2 = ANY(ARRAY_AGG(status::integer)) THEN 'active' ELSE 'inactive' END
    , NOW()
    , NOW()
    , JSON_AGG(
        JSON_BUILD_OBJECT(
            'id', legacy_id,
            'source', legacy_source
        )
        ORDER BY legacy_id, legacy_source
    )
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
    , legacy_sources
)
SELECT
    production.id
    , production.name
    , production.phone
    , production.status
    , production.created_at
    , production.updated_at
    , production.legacy_sources
FROM
    public.companies production
    LEFT JOIN transform.companies_legacy legacy
        ON production.name = legacy.name
;
