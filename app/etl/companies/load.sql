INSERT INTO public.companies
(
    legacy_id
    , location_id
    , "name"
    , phone
    , status
    , created_at
    , updated_at
)
SELECT
    companies.id
    , MAX(locations.id)
    , companies."name"
    , companies.phone
    , companies.status
    , companies.created_at
    , companies.updated_at
FROM
    transform.companies companies
    LEFT JOIN transform.company_aliases aliases
        ON companies.id = aliases.company_id
    LEFT JOIN public.locations locations
        ON aliases.legacy_location_id = locations.legacy_id
        AND aliases.legacy_source = locations.legacy_source
GROUP BY
    companies.id
;
