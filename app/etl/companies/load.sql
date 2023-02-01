INSERT INTO public.companies
(
    legacy_id
    , location_id
    , "name"
    , phone
    , status
    , created_at
    , updated_at
    , legacy_user_id
)
SELECT
    companies.legacy_id
    , locations.id
    , companies."name"
    , companies.phone
    , companies.status
    , companies.created_at
    , companies.updated_at
    , companies.legacy_user_id
FROM
    transform.companies companies
    LEFT JOIN public.locations locations
        ON companies.legacy_location_id = locations.legacy_id
        AND companies.legacy_source = locations.legacy_source
;
