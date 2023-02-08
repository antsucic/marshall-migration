INSERT INTO public.companies
(
    legacy_id
    , "name"
    , phone
    , status
    , created_at
    , updated_at
)
SELECT
    companies.id
    , companies."name"
    , companies.phone
    , companies.status
    , companies.created_at
    , companies.updated_at
FROM
    transform.companies companies
    LEFT JOIN transform.company_aliases aliases
        ON companies.id = aliases.company_id
;
