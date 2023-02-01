INSERT INTO public.locations_users
(
    location_id
    , user_id
)
SELECT
    locations.id
     , users.id
FROM
    staging.locations_users relations
    JOIN public.users users
        ON relations.legacy_user_id = users.legacy_id
        AND relations.legacy_source = users.legacy_source
    JOIN public.locations locations
        ON relations.legacy_location_id = locations.legacy_id
        AND relations.legacy_source = locations.legacy_source
;
