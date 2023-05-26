UPDATE
    public.companies
SET
    "name" = updates.name
    , phone = updates.phone
    , status = updates.status
    , updated_at = updates.updated_at
    , legacy_sources = updates.legacy_sources
FROM
    transform.companies_production_updated updates
WHERE
    companies.id = updates.id
;

INSERT INTO public.companies
(
    "name"
    , phone
    , status
    , created_at
    , updated_at
    , legacy_sources
)
SELECT
    "name"
    , phone
    , status
    , created_at
    , updated_at
    , legacy_sources
FROM
    transform.companies_production_added
;
