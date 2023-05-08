UPDATE
    public.companies
SET
    "name" = updates.name
    , phone = updates.phone
    , status = updates.status
    , updated_at = updates.updated_at
    , legacy_ids = updates.legacy_ids
    , legacy_source = updates.legacy_source
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
    , legacy_ids
)
SELECT
    "name"
    , phone
    , status
    , created_at
    , updated_at
    , legacy_ids
FROM
    transform.companies_production_added
;
