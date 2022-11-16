INSERT INTO public.facilities
(
    legacy_id
    , company_id
    , location_id
    , "name"
    , facility_type
    , status
    , created_at
    , updated_at
    , image_identificator
)
SELECT
    facilities.legacy_id
    , companies.id
    , locations.id
    , facilities."name"
    , facilities.facility_type
    , facilities.status
    , facilities.created_at
    , facilities.updated_at
    , NULL
FROM
    transform.facilities facilities
    LEFT JOIN public.companies companies
        ON facilities.legacy_company_id = companies.legacy_id
    LEFT JOIN public.locations locations
        ON facilities.legacy_location_id = locations.legacy_id
;
