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
    JOIN transform.owner_aliases owner_aliases
        ON owner_aliases.legacy_company_id = company_aliases.legacy_id
        AND owner_aliases.legacy_source = company_aliases.legacy_source
    JOIN public.users users
        ON owner_aliases.owner_id = users.legacy_owner_id
;
