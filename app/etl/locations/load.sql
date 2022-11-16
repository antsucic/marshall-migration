INSERT INTO public.locations
(
    legacy_id
    , address
    , city
    , state
    , country
    , postal_code
    , created_at
    , updated_at
)
SELECT
    legacy_id
    , address
    , city
    , state
    , country
    , postal_code
    , created_at
    , updated_at
FROM
    transform.locations
;
