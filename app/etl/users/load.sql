INSERT INTO public.users
(
    legacy_id
    , email
    , first_name
    , last_name
    , status
    , "role"
    , created_at
    , updated_at
)
SELECT
    id
    , email
    , first_name
    , last_name
    , status
    , "role"
    , COALESCE(created_at, NOW())
    , updated_at
FROM
    transform.users
;
