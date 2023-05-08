UPDATE
    public.organizations
SET
    "name" = updates.name
    , updated_at = updates.updated_at
    , legacy_ids = updates.legacy_ids
FROM
    transform.organizations_production_updated updates
WHERE
    organizations.id = updates.id
;

INSERT INTO public.organizations
(
    "name"
    , created_at
    , updated_at
    , legacy_ids
)
SELECT
    "name"
    , created_at
    , updated_at
    , legacy_ids
FROM
    transform.organizations_production_added
;
