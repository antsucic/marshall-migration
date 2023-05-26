WITH last_insert AS (
    SELECT
        MAX(created_at)::DATE date
    FROM
        transform.documents_legacy
    WHERE
        legacy_source IS NOT NULL
)
INSERT INTO transform.documents_production_added
(
    item_number
    , status
    , document_type
    , created_at
    , updated_at
    , documentable_type
    , documentable_id
    , subproject
    , legacy_ids
    , legacy_source
)
SELECT
    legacy.item_number
    , legacy.status
    , legacy.document_type
    , legacy.created_at
    , legacy.updated_at
    , CASE WHEN facilities.id IS NOT NULL THEN 'Facility' ELSE 'Project' END
    , COALESCE(facilities.id, projects.id)
    , legacy.subproject
    , legacy.legacy_ids
    , legacy.legacy_source
FROM
    transform.documents_legacy legacy
    JOIN last_insert
        ON legacy.created_at >= last_insert.date
    LEFT JOIN public.facilities facilities
        ON legacy.legacy_documentable_id = facilities.legacy_id
        AND legacy.legacy_source = facilities.legacy_source
    LEFT JOIN public.projects projects
        ON legacy.legacy_documentable_id = projects.legacy_id
        AND legacy.legacy_source = projects.legacy_source
    LEFT JOIN transform.documents_production production
        ON legacy.legacy_ids && production.legacy_ids
        AND legacy.legacy_source = production.legacy_source
WHERE
    production.id IS NULL
;
