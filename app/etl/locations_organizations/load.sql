INSERT INTO public.locations_organizations
(
    location_id
    , organization_id
)
SELECT
    locations.id
     , organizations.id
FROM
    public.organizations organizations
    JOIN public.locations locations
        ON organizations.legacy_location_ids ~ locations.legacy_id
;
