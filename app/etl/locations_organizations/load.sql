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
    JOIN transform.organization_aliases aliases
        ON organizations.legacy_id = aliases.organization_id
    JOIN public.locations locations
        ON aliases.legacy_location_id = locations.legacy_id
        AND aliases.legacy_source = locations.legacy_source
;
