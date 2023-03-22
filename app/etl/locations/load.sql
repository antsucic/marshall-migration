INSERT INTO public.locations
(
    legacy_id
    , legacy_facility_id
    , legacy_source
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
    , legacy_facility_id
    , legacy_source
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
