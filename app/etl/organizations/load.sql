INSERT INTO public.organizations
(
    legacy_id
    , "name"
    , created_at
    , updated_at
)
SELECT
    id
    , "name"
    , created_at
    , updated_at
FROM
    transform.organizations
;
