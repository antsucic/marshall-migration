INSERT INTO public.companies_users
(
    company_id
    , user_id
)
SELECT
    companies.id
     , users.id
FROM
    public.companies companies
    LEFT JOIN public.users users
        ON companies.legacy_user_id = users.legacy_id
;
