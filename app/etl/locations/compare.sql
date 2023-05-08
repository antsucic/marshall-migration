INSERT INTO transform.locations_production_added
(
    address
    , city
    , state
    , postal_code
    , country
    , created_at
    , updated_at
    , legacy_id
    , legacy_facility_id
    , legacy_source
)
SELECT
    legacy.address
    , legacy.city
    , legacy.state
    , legacy.postal_code
    , legacy.country
    , legacy.created_at
    , legacy.updated_at
    , legacy.legacy_id
    , legacy.legacy_facility_id
    , legacy.legacy_source
FROM
    transform.locations_legacy legacy
    LEFT JOIN transform.locations_production production
        ON legacy.legacy_id = production.legacy_id
        AND legacy.legacy_source = production.legacy_source
WHERE
    production.id IS NULL
;

INSERT INTO transform.locations_production_updated
(
    id
    , address
    , city
    , state
    , postal_code
    , country
    , updated_at
    , legacy_facility_id
)
SELECT
    production.id
    , legacy.address
    , legacy.city
    , legacy.state
    , legacy.postal_code
    , legacy.country
    , legacy.updated_at
    , legacy.legacy_facility_id
FROM
    transform.locations_legacy legacy
    JOIN transform.locations_production production
         ON legacy.legacy_id = production.legacy_id
         AND legacy.legacy_source = production.legacy_source
WHERE
    COALESCE(legacy.address, '') <> COALESCE(production.address, '')
    OR COALESCE(legacy.city, '') <> COALESCE(production.city, '')
    OR COALESCE(legacy.state, '') <> COALESCE(production.state, '')
    OR COALESCE(legacy.postal_code, '') <> COALESCE(production.postal_code, '')
    OR COALESCE(legacy.country, '') <> COALESCE(production.country, '')
    OR COALESCE(legacy.legacy_facility_id, '') <> COALESCE(production.legacy_facility_id, '')
;
