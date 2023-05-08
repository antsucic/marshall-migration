UPDATE
    public.facilities
SET
    company_id = updates.company_id
    , location_id = updates.location_id
    , "name" = updates.name
    , facility_type = updates.facility_type
    , status = updates.status
    , updated_at = updates.updated_at
FROM
    transform.facilities_production_updated updates
WHERE
    facilities.id = updates.id
;

INSERT INTO public.facilities
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
    company_id
    , location_id
    , "name"
    , facility_type
    , status
    , created_at
    , updated_at
    , legacy_id
    , legacy_source
FROM
    transform.facilities_production_added
;
