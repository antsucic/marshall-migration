INSERT INTO public.locations_users
(
    location_id
    , user_id
)
SELECT DISTINCT
    locations.id
     , users.id
FROM
    public.users users
    CROSS JOIN LATERAL JSONB_TO_RECORDSET(legacy_ids::jsonb)
        AS legacy(id TEXT, source TEXT)
    JOIN staging.locations_users relations
        ON legacy.id = relations.legacy_user_id
        AND legacy.source = relations.legacy_source
    JOIN public.locations locations
        ON relations.legacy_location_id = locations.legacy_id
        AND relations.legacy_source = locations.legacy_source
    LEFT JOIN public.locations_users target
        ON locations.id = target.location_id
        AND users.id = target.user_id
WHERE
    target.id IS NULL
;
