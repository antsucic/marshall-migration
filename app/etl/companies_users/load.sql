INSERT INTO public.companies_users
(
    company_id
    , user_id
)
SELECT DISTINCT
    companies.id
     , users.id
FROM
    public.companies companies
    JOIN transform.company_aliases company_aliases
        ON companies.id = company_aliases.company_id
    JOIN transform.users user_transformation
         ON company_aliases.legacy_id = user_transformation.legacy_company_id
    JOIN public.users users
        ON user_transformation.id = users.legacy_id
;
