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
    JOIN public.locations locations
        ON locations.legacy_id = relations.legacy_location_id
    JOIN public.organizations organizations
        ON organizations.legacy_ids ~ relations.legacy_organization_id
;
