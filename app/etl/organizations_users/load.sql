INSERT INTO public.organizations_users
(
    organization_id
    , user_id
    , phone
    , mobile_phone
    , location_id
)
SELECT DISTINCT
    organizations.id
    , users.id
    , relations.phone
    , relations.mobile_phone
    , locations.id
FROM
    staging.organizations_users relations
    JOIN (
        SELECT
            users.id
            , legacy.id legacy_id
            , legacy.source legacy_source
        FROM
            public.users users
            CROSS JOIN LATERAL JSONB_TO_RECORDSET(legacy_ids::jsonb)
                AS legacy(id TEXT, source TEXT)
    ) users
        ON relations.legacy_user_id = users.legacy_id
        AND relations.legacy_source = users.legacy_source
    JOIN (
        SELECT
            organizations.id
            , legacy.id legacy_id
            , legacy.source legacy_source
        FROM
            public.organizations organizations
            CROSS JOIN LATERAL JSONB_TO_RECORDSET(legacy_ids::jsonb)
                AS legacy(id TEXT, source TEXT)
    ) organizations
        ON relations.legacy_organization_id = organizations.legacy_id
        AND relations.legacy_source = organizations.legacy_source
    JOIN public.locations locations
        ON locations.legacy_id = relations.legacy_location_id
        AND locations.legacy_source = relations.legacy_source
    LEFT JOIN public.organizations_users target
         ON target.organization_id = organizations.id
         AND target.user_id = users.id
         AND target.location_id = locations.id
WHERE
    target.id IS NULL
;
