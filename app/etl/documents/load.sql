UPDATE
    public.documents
SET
    item_number = updates.item_number
    , status = updates.status
    , document_type = updates.document_type
    , updated_at = updates.updated_at
    , documentable_type = updates.documentable_type
    , documentable_id = updates.documentable_id
    , subproject = updates.subproject
    , legacy_ids = updates.legacy_ids
    , legacy_source = updates.legacy_source
FROM
    transform.documents_production_updated updates
WHERE
    documents.id = updates.id
;

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
    , legacy_ids
    , legacy_source
)
SELECT
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
FROM
    transform.documents_production_added
;

UPDATE
    public.document_revisions
SET
    document_id = updates.document_id
    , "name" = updates.name
    , status = updates.status
    , description = updates.description
    , document_attributes = updates.document_attributes
    , created_at = updates.created_at
    , updated_at = updates.updated_at
    , revision = updates.revision
    , discipline = updates.discipline
    , image_identificator = updates.image_identificator
    , is_old = updates.is_old
    , folder_id = updates.folder_id
    , legacy_path = updates.legacy_path
    , legacy_filename = updates.legacy_filename
FROM
    transform.document_revisions_production_updated updates
WHERE
    document_revisions.id = updates.id
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
     , revisions.name
     , revisions.status
     , revisions.description
     , revisions.document_attributes
     , revisions.created_at
     , revisions.updated_at
     , revisions.revision
     , revisions.discipline
     , revisions.is_old
     , revisions.folder_id
     , revisions.legacy_id
     , revisions.legacy_source
     , revisions.legacy_path
     , revisions.legacy_filename
FROM
    transform.document_revisions_production_added revisions
    JOIN public.documents
        ON revisions.legacy_id <@ documents.legacy_ids
        AND revisions.legacy_source = documents.legacy_source
;
