INSERT INTO transform.facilities_production_added
(
    company_id
    , location_id
    , "name"
    , facility_type
    , status
    , created_at
    , updated_at
    , legacy_id
    , legacy_source
)
SELECT
    companies.id
    , locations.id
    , legacy.name
    , legacy.facility_type
    , legacy.status
    , legacy.created_at
    , legacy.updated_at
    , legacy.legacy_id
    , legacy.legacy_source
FROM
    transform.facilities_legacy legacy
    LEFT JOIN public.companies companies
        ON legacy.legacy_company_id = ANY(companies.legacy_ids)
        AND legacy.legacy_source = companies.legacy_source
    LEFT JOIN public.locations locations
        ON legacy.legacy_id = locations.legacy_facility_id
        AND legacy.legacy_source = locations.legacy_source
    LEFT JOIN transform.facilities_production production
        ON legacy.legacy_id = production.legacy_id
        AND legacy.legacy_source = production.legacy_source
WHERE
    production.id IS NULL
;

INSERT INTO transform.facilities_production_updated
(
    id
    , company_id
    , location_id
    , "name"
    , facility_type
    , status
    , updated_at
)
SELECT
    production.id
    , companies.id
    , locations.id
    , legacy.name
    , legacy.facility_type
    , legacy.status
    , legacy.updated_at
FROM
    transform.facilities_legacy legacy
    JOIN transform.facilities_production production
         ON legacy.legacy_id = production.legacy_id
         AND legacy.legacy_source = production.legacy_source
    JOIN public.companies companies
        ON legacy.legacy_company_id = ANY(companies.legacy_ids)
        AND legacy.legacy_source = companies.legacy_source
    JOIN public.locations locations
         ON legacy.legacy_id = locations.legacy_facility_id
        AND legacy.legacy_source = locations.legacy_source
WHERE
    COALESCE(companies.id, 0) <> COALESCE(production.company_id, 0)
    OR COALESCE(locations.id, 0) <> COALESCE(production.location_id, 0)
    OR COALESCE(legacy.name, '') <> COALESCE(production.name, '')
    OR COALESCE(legacy.facility_type, '') <> COALESCE(production.facility_type, '')
    OR COALESCE(legacy.status, '') <> COALESCE(production.status, '')
;
