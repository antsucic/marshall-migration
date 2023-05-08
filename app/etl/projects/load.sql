UPDATE
    public.projects
SET
    "name" = updates.name
    , number = updates.number
    , description = updates.description
    , status = updates.status
    , updated_at = updates.updated_at
    , facility_id = updates.facility_id
FROM
    transform.projects_production_updated updates
WHERE
    projects.id = updates.id
;

INSERT INTO public.projects
(
    "name"
    , number
    , description
    , status
    , created_at
    , updated_at
    , facility_id
    , legacy_id
    , legacy_source
)
SELECT
    "name"
    , number
    , description
    , status
    , created_at
    , updated_at
    , facility_id
    , legacy_id
    , legacy_source
FROM
    transform.projects_production_added
;
