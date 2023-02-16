INSERT INTO public.folders
(
    "name"
    , created_at
    , updated_at
    , folderable_type
    , folderable_id
    , legacy_id
    , legacy_source
)
SELECT
    folders."name"
    , folders.created_at
    , folders.updated_at
    , CASE WHEN projects.id IS NOT NULL THEN 'Project' ELSE 'Facility' END
    , COALESCE(projects.id, facilities.id)
    , folders.legacy_id
    , folders.legacy_source
FROM
    transform.folders folders
    LEFT JOIN public.facilities facilities
        ON folders.legacy_folderable_id = facilities.legacy_id
        AND folders.legacy_source = facilities.legacy_source
    LEFT JOIN public.projects projects
        ON folders.legacy_folderable_id = projects.legacy_id
        AND folders.legacy_source = projects.legacy_source
;

UPDATE
    public.folders children
SET
    parent_id = parents.id
FROM
    transform.folders relations
    JOIN public.folders parents
        ON relations.legacy_parent_id = parents.legacy_id
        AND relations.legacy_source = parents.legacy_source
WHERE
    children.legacy_id = relations.legacy_id
    AND children.legacy_source = relations.legacy_source
;
