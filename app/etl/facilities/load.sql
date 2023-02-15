INSERT INTO public.facilities
(
    legacy_id
    , legacy_source
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
    , facilities.legacy_source
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
    JOIN transform.company_aliases aliases
        ON facilities.legacy_company_id = aliases.legacy_id
        AND facilities.legacy_source = aliases.legacy_source
    JOIN public.companies companies
        ON aliases.company_id = companies.id
    LEFT JOIN public.locations locations
        ON facilities.legacy_location_id = locations.legacy_id
        AND facilities.legacy_source = locations.legacy_source
;
