UPDATE
    public.locations
SET
    address = updates.address
    , city = updates.city
    , state = updates.state
    , country = updates.country
    , postal_code = updates.postal_code
    , updated_at = updates.updated_at
    , legacy_facility_id = updates.legacy_facility_id
FROM
    transform.locations_production_updated updates
WHERE
    locations.id = updates.id
;

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
    transform.locations_production_added
;
