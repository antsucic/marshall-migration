INSERT INTO public.companies_users
(
    company_id
    , user_id
)
SELECT
    company_id
    , user_id
FROM
    transform.companies_users_production_added
;
