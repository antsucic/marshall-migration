INSERT INTO public.organizations
(
    legacy_ids
    , legacy_location_ids
    , "name"
    , created_at
    , updated_at
)
SELECT
    legacy_ids
    , legacy_location_ids
    , "name"
    , created_at
    , updated_at
FROM
    transform.organizations
;
