INSERT INTO transform.locations_legacy
(
    legacy_id
    , legacy_facility_id
    , legacy_source
    , address
    , city
    , state
    , postal_code
    , country
    , created_at
    , updated_at
)
SELECT
    legacy_id
    , legacy_facility_id
    , legacy_source
    , TRIM(CASE WHEN address_2 IS NOT NULL THEN address_1 || ', ' || address_2 ELSE address_1 END)
    , city
    , region
    , postal_code
    , 'US'
    , COALESCE(created_at, NOW())
    , COALESCE(updated_at, NOW())
FROM
    staging.locations
;
