INSERT INTO public.organizations_users
(
    organization_id
    , user_id
    , phone
    , mobile_phone
    , location_id
)
SELECT
    organizations.id
    , users.id
    , relations.phone
    , relations.mobile_phone
    , locations.id
FROM
    staging.organizations_users relations
    JOIN transform.user_aliases user_aliases
        ON user_aliases.legacy_id = relations.legacy_user_id
        AND user_aliases.legacy_source = relations.legacy_source
    JOIN public.users users
        ON user_aliases.user_id = users.legacy_id
    JOIN public.locations locations
        ON locations.legacy_id = relations.legacy_location_id
        AND locations.legacy_source = relations.legacy_source
    JOIN transform.organization_aliases organization_aliases
        ON organization_aliases.legacy_id = relations.legacy_organization_id
        AND organization_aliases.legacy_source = relations.legacy_source
    JOIN public.organizations organizations
        ON organization_aliases.user_id = organizations.legacy_id
;
