UPDATE
    public.users
SET
    email = updates.email
    , first_name = updates.first_name
    , last_name = updates.last_name
    , status = updates.status
    , "role" = updates.role
    , updated_at = updates.updated_at
    , legacy_ids = updates.legacy_ids
FROM
    transform.users_production_updated updates
WHERE
    users.id = updates.id
;

INSERT INTO public.users
(
    email
    , first_name
    , last_name
    , status
    , "role"
    , created_at
    , updated_at
    , legacy_ids
)
SELECT
    email
    , first_name
    , last_name
    , status
    , "role"
    , created_at
    , updated_at
    , legacy_ids
FROM
    transform.users_production_added
;
