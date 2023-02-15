INSERT INTO public.projects
(
    legacy_id
    , legacy_source
    , facility_id
    , "name"
    , status
    , created_at
    , updated_at
)
SELECT
    projects.legacy_id
    , projects.legacy_source
    , facilities.id
    , projects."name"
    , projects.status
    , projects.created_at
    , projects.updated_at
FROM
    transform.projects projects
    LEFT JOIN public.facilities facilities
        ON projects.legacy_facility_id = facilities.legacy_id
        AND projects.legacy_source = facilities.legacy_source
;
