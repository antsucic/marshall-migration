INSERT INTO public.documents
(
    item_number
    , status
    , document_type
    , created_at
    , updated_at
    , documentable_type
    , documentable_id
    , subproject
    , legacy_id
)
SELECT
    documents.item_number
    , documents.status
    , documents.document_type
    , documents.created_at
    , documents.updated_at
    , CASE WHEN projects.id IS NOT NULL THEN 'Project' ELSE 'Facility' END
    , COALESCE(projects.id, facilities.id)
    , documents.subproject
    , documents.id
FROM
    transform.documents
    LEFT JOIN public.facilities facilities
        ON documents.legacy_documentable_id = facilities.legacy_id
        AND documents.legacy_source = facilities.legacy_source
    LEFT JOIN public.projects projects
        ON documents.legacy_documentable_id = projects.legacy_id
        AND documents.legacy_source = projects.legacy_source
;

INSERT INTO public.document_revisions
(
    document_id
    , "name"
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
    documents.id
     , revisions."name"
     , revisions.status
     , revisions.description
     , revisions.document_attributes
     , revisions.created_at
     , revisions.updated_at
     , revisions.revision
     , revisions.discipline
     , revisions.is_old
     , folders.id
     , revisions.legacy_id
     , revisions.legacy_source
     , revisions.legacy_path
     , revisions.legacy_filename
FROM
    transform.document_revisions revisions
    JOIN public.documents
        ON revisions.document_id = documents.legacy_id
    LEFT JOIN public.folders
        ON revisions.legacy_folder_id = folders.legacy_id
;
