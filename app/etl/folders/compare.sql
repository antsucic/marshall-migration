INSERT INTO transform.folders_production_added
(
    parent_id
    , "name"
    , created_at
    , updated_at
    , folderable_type
    , folderable_id
    , legacy_id
    , legacy_source
)
SELECT
    parents.id
    , legacy.name
    , legacy.created_at
    , legacy.updated_at
    , CASE WHEN facilities.id IS NOT NULL THEN 'Facility' ELSE 'Project' END
    , COALESCE(facilities.id, projects.id)
    , legacy.legacy_id
    , legacy.legacy_source
FROM
    transform.folders_legacy legacy
    LEFT JOIN transform.folders_production production
        ON legacy.legacy_id = production.legacy_id
        AND legacy.legacy_source = production.legacy_source
    LEFT JOIN public.facilities facilities
        ON legacy.legacy_folderable_id = facilities.legacy_id
        AND legacy.legacy_source = facilities.legacy_source
    LEFT JOIN public.projects projects
        ON legacy.legacy_folderable_id = projects.legacy_id
        AND legacy.legacy_source = projects.legacy_source
    LEFT JOIN public.folders parents
        ON legacy.legacy_parent_id = parents.legacy_id
        AND legacy.legacy_source = parents.legacy_source
WHERE
    production.id IS NULL
;

INSERT INTO transform.folders_production_updated
(
    id
    , parent_id
    , "name"
    , updated_at
    , folderable_type
    , folderable_id
)
SELECT
    production.id
    , MIN(parents.id)
    , MAX(legacy.name)
    , MAX(legacy.updated_at)
    , CASE WHEN MIN(facilities.id) IS NOT NULL THEN 'Facility' ELSE 'Project' END
    , COALESCE(MIN(facilities.id), MIN(projects.id))
FROM
    transform.folders_legacy legacy
    JOIN transform.folders_production production
         ON legacy.legacy_id = production.legacy_id
         AND legacy.legacy_source = production.legacy_source
    LEFT JOIN public.facilities facilities
        ON legacy.legacy_folderable_id = facilities.legacy_id
        AND legacy.legacy_source = facilities.legacy_source
    LEFT JOIN public.projects projects
        ON legacy.legacy_folderable_id = projects.legacy_id
        AND legacy.legacy_source = projects.legacy_source
    LEFT JOIN public.folders parents
        ON legacy.legacy_parent_id = parents.legacy_id
        AND legacy.legacy_source = parents.legacy_source
WHERE
    COALESCE(legacy.name, '') <> COALESCE(production.name, '')
    OR COALESCE(CASE WHEN facilities.id IS NOT NULL THEN 'Facility' ELSE 'Project' END, '') <> COALESCE(production.folderable_type, '')
    OR COALESCE(facilities.id, projects.id, 0) <> COALESCE(production.folderable_id, 0)
    OR COALESCE(parents.id, 0) <> COALESCE(production.parent_id, 0)
GROUP BY
    production.id
;
