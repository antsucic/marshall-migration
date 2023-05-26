WITH companies AS (
    SELECT
        companies.id
        , legacy.id legacy_id
        , legacy.source legacy_source
    FROM
        public.companies companies
        CROSS JOIN LATERAL JSONB_TO_RECORDSET(legacy_sources::jsonb)
            AS legacy(id TEXT, source TEXT)
)
INSERT INTO transform.document_custom_attributes_production_added
(
    company_id
    , name
    , document_type
    , is_required
    , is_deleted
    , created_at
    , updated_at
    , legacy_id
    , legacy_source
)
SELECT
    companies.id
    , legacy.name
    , legacy.document_type
    , legacy.is_required
    , legacy.is_deleted
    , legacy.created_at
    , legacy.created_at
    , legacy.legacy_id
    , legacy.legacy_source
FROM
    transform.document_custom_attributes_legacy legacy
    LEFT JOIN transform.document_custom_attributes_production production
        ON legacy.name = production.name
    LEFT JOIN companies
        ON legacy.legacy_company_id = companies.legacy_id
        AND legacy.legacy_source = companies.legacy_source
WHERE
    production.id IS NULL
;
