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
    JOIN public.users users
        ON relations.legacy_user_id = users.legacy_id
        AND relations.legacy_source = users.legacy_source
    JOIN public.locations locations
        ON locations.legacy_id = relations.legacy_location_id
        AND locations.legacy_source = relations.legacy_source
    JOIN public.organizations organizations
        ON organizations.legacy_ids ~ CONCAT(relations.legacy_source, ':', relations.legacy_organization_id)
;
