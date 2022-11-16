INSERT INTO public.users
(
    email
    , first_name
    , last_name
    , status
    , "role"
    , created_at
    , updated_at
    , legacy_id
)
SELECT
    email
    , first_name
    , last_name
    , status
    , "role"
    , COALESCE(created_at, NOW())
    , updated_at
    , legacy_id
FROM
    transform.users
;
