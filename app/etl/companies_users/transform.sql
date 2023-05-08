INSERT INTO transform.companies_users_production
(
    company_id
    , user_id
)
SELECT
    company_id
     , user_id
FROM
    public.companies_users
;
