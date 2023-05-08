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

INSERT INTO transform.documents_production_updated
(
    id
    , item_number
    , status
    , document_type
    , updated_at
    , documentable_type
    , documentable_id
    , subproject
    , legacy_ids
    , legacy_source
)
SELECT
    production.id
    , legacy.item_number
    , legacy.status
    , legacy.document_type
    , legacy.updated_at
    , CASE WHEN facilities.id IS NOT NULL THEN 'Facility' ELSE 'Project' END
    , COALESCE(facilities.id, projects.id)
    , legacy.subproject
    , legacy.legacy_ids
    , legacy.legacy_source
FROM
    transform.documents_legacy legacy
    LEFT JOIN public.facilities facilities
        ON legacy.legacy_documentable_id = facilities.legacy_id
        AND legacy.legacy_source = facilities.legacy_source
    LEFT JOIN public.projects projects
        ON legacy.legacy_documentable_id = projects.legacy_id
        AND legacy.legacy_source = projects.legacy_source
    JOIN transform.documents_production production
        ON legacy.legacy_ids = production.legacy_ids
        AND legacy.legacy_source = production.legacy_source
WHERE
    COALESCE(legacy.item_number, '') <> COALESCE(production.item_number, '')
    OR COALESCE(legacy.status, '') <> COALESCE(production.status, '')
    OR COALESCE(legacy.document_type, '') <> COALESCE(production.document_type, '')
    OR COALESCE(CASE WHEN facilities.id IS NOT NULL THEN 'Facility' ELSE 'Project' END, '') <> COALESCE(production.documentable_type, '')
    OR COALESCE(facilities.id, projects.id, 0) <> COALESCE(production.documentable_id, 0)
    OR COALESCE(legacy.subproject, '') <> COALESCE(production.subproject, '')
    OR legacy.legacy_ids <> production.legacy_ids
;

INSERT INTO transform.document_revisions_production_added
(
    "name"
    , status
    , description
    , document_attributes
    , created_at
    , updated_at
    , revision
    , discipline
    , is_old
    , folder_id
    , legacy_id
    , legacy_source
    , legacy_path
    , legacy_filename
)
SELECT
    legacy."name"
    , legacy.status
    , legacy.description
    , legacy.document_attributes
    , legacy.created_at
    , legacy.updated_at
    , legacy.revision
    , legacy.discipline
    , legacy.is_old
    , folders.id
    , legacy.legacy_id
    , legacy.legacy_source
    , legacy.legacy_path
    , legacy.legacy_filename
FROM
    transform.document_revisions_legacy legacy
    LEFT JOIN public.folders
        ON legacy.legacy_folder_id = folders.legacy_id
    LEFT JOIN transform.document_revisions_production production
        ON legacy.legacy_id = production.legacy_id
        AND legacy.legacy_source = production.legacy_source
WHERE
    production.id IS NULL
;

INSERT INTO transform.document_revisions_production_updated
(
    id
    , "name"
    , status
    , description
    , document_attributes
    , updated_at
    , revision
    , discipline
    , image_identificator
    , is_old
    , folder_id
    , legacy_path
    , legacy_filename
)
SELECT
    production.id
    , legacy.name
    , legacy.status
    , legacy.description
    , legacy.document_attributes
    , legacy.updated_at
    , legacy.revision
    , legacy.discipline
    , CASE
        WHEN COALESCE(legacy.legacy_path, '') <> COALESCE(production.legacy_path, '') THEN NULL
        WHEN COALESCE(legacy.legacy_filename, '') <> COALESCE(production.legacy_filename, '') THEN NULL
        ELSE production.image_identificator
    END
    , legacy.is_old
    , folders.id
    , legacy.legacy_path
    , legacy.legacy_filename
FROM
    transform.document_revisions_legacy legacy
    LEFT JOIN public.folders
        ON legacy.legacy_folder_id = folders.legacy_id
    JOIN transform.document_revisions_production production
        ON legacy.legacy_id = production.legacy_id
        AND legacy.legacy_source = production.legacy_source
WHERE
    COALESCE(legacy.name, '') <> COALESCE(production.name, '')
    OR COALESCE(legacy.status, '') <> COALESCE(production.status, '')
    OR COALESCE(legacy.description, '') <> COALESCE(production.description, '')
    OR legacy.document_attributes <> production.document_attributes
    OR COALESCE(legacy.revision, '') <> COALESCE(production.revision, '')
    OR COALESCE(legacy.discipline, '') <> COALESCE(production.discipline, '')
    OR legacy.is_old <> production.is_old
    OR COALESCE(folders.id, 0) <> COALESCE(production.folder_id, 0)
    OR COALESCE(legacy.legacy_path, '') <> COALESCE(production.legacy_path, '')
    OR COALESCE(legacy.legacy_filename, '') <> COALESCE(production.legacy_filename, '')
;
