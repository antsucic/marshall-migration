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
    JOIN transform.companies_production companies
        ON legacy.company_id = ANY(companies.legacy_ids)
        AND legacy.source = companies.legacy_source
    LEFT JOIN transform.companies_users_production companies_users
        ON users.id = companies_users.user_id
        AND companies.id = companies_users.company_id
WHERE
    legacy.company_id IS NOT NULL
    AND companies_users.id IS NULL
;
