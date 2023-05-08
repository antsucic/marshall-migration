INSERT INTO public.locations_organizations
(
    location_id
    , organization_id
)
SELECT DISTINCT
    locations.id
    , organizations.id
FROM
    public.organizations organizations
    CROSS JOIN LATERAL JSONB_TO_RECORDSET(legacy_ids::jsonb)
        AS legacy(source TEXT, location_id TEXT)
    JOIN public.locations locations
        ON legacy.location_id = locations.legacy_id
        AND legacy.source = locations.legacy_source
    LEFT JOIN public.locations_organizations target
        ON locations.id = target.location_id
        AND organizations.id = target.organization_id
WHERE
    target.location_id IS NULL
;
