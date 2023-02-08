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
    JOIN transform.user_aliases user_aliases
         ON user_aliases.legacy_id = relations.legacy_user_id
         AND user_aliases.legacy_source = relations.legacy_source
    JOIN public.users users
         ON user_aliases.user_id = users.legacy_id
    JOIN public.locations locations
        ON relations.legacy_location_id = locations.legacy_id
        AND relations.legacy_source = locations.legacy_source
;
