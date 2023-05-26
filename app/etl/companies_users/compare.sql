WITH companies AS (
    SELECT
        companies.id
        , legacy.id legacy_id
        , legacy.source legacy_source
    FROM
        transform.companies_production companies
        CROSS JOIN LATERAL JSONB_TO_RECORDSET(legacy_sources::jsonb)
            AS legacy(id TEXT, source TEXT)
)
INSERT INTO transform.companies_users_production_added
(
    company_id
    , user_id
)
SELECT
    companies.id
    , users.id
FROM
    transform.users_production users
    CROSS JOIN LATERAL JSONB_TO_RECORDSET(legacy_ids::jsonb)
        AS legacy(company_id TEXT, source TEXT)
    JOIN companies
        ON legacy.company_id = companies.legacy_id
        AND legacy.source = companies.legacy_source
    LEFT JOIN transform.companies_users_production companies_users
        ON users.id = companies_users.user_id
        AND companies.id = companies_users.company_id
WHERE
    legacy.company_id IS NOT NULL
    AND companies_users.company_id IS NULL
;
