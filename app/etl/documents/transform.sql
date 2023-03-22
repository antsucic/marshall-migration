INSERT INTO transform.documents
(
    legacy_documentable_id
    , legacy_source
    , item_number
    , status
    , document_type
    , created_at
    , updated_at
    , subproject
)
SELECT
    documents.legacy_documentable_id
    , documents.legacy_source
    , numbers.name
    , CASE WHEN 2 = ANY(ARRAY_AGG(documents.status::integer)) THEN 'active' ELSE 'inactive' END
    , CASE documents.document_type
        WHEN 'SYS_ITEMTYPE_DRAWING' THEN 'DRAWING'
        WHEN 'SYS_ITEMTYPE_MH_PLAN' THEN 'DRAWING'
        WHEN 'SYS_ITEMTYPE_SKETCH' THEN 'DRAWING'
        WHEN 'SYS_ITEMTYPE_MH_SPEC' THEN 'SPECIFICATION'
        WHEN 'SYS_ITEMTYPE_SPEC' THEN 'SPECIFICATION'
        ELSE 'UPLOADED_FILE'
     END new_document_type
    , MIN(documents.created_at)
    , MAX(documents.updated_at)
    , subprojects.name
FROM
    staging.documents
    LEFT JOIN staging.document_numbers numbers
        ON documents.legacy_id = numbers.legacy_id
    LEFT JOIN staging.document_subprojects subprojects
        ON documents.legacy_id = subprojects.legacy_id
GROUP BY
    documents.legacy_documentable_id,
    documents.legacy_source,
    new_document_type,
    numbers.name,
    subprojects.name
;

INSERT INTO transform.document_revisions
(
    document_id
    , legacy_id
    , legacy_folder_id
    , legacy_source
    , legacy_path
    , legacy_filename
    , "name"
    , status
    , description
    , created_at
    , updated_at
    , revision
    , discipline
    , is_old
)
SELECT
    transformation.id
    , stage.legacy_id
    , stage.legacy_folder_id
    , stage.legacy_source
    , RTRIM(RTRIM(RTRIM(stage.file_path, stage.file_name), '\'), '/')
    , stage.file_name
    , stage.name
    , CASE WHEN stage.status::integer = 2 THEN 'active' ELSE 'inactive' END
    , stage.description
    , stage.created_at
    , stage.updated_at
    , revisions.name
    , disciplines.name
    , NOT stage.is_not_old::boolean
FROM
    staging.documents stage
    LEFT JOIN staging.document_numbers numbers
        ON stage.legacy_id = numbers.legacy_id
    LEFT JOIN staging.document_subprojects subprojects
        ON stage.legacy_id = subprojects.legacy_id
    LEFT JOIN staging.document_disciplines disciplines
        ON stage.legacy_id = disciplines.legacy_id
    LEFT JOIN staging.document_revision_numbers revisions
        ON stage.legacy_id = revisions.legacy_id
    JOIN transform.documents transformation
        ON stage.legacy_documentable_id = transformation.legacy_documentable_id
        AND stage.legacy_source = transformation.legacy_source
        AND numbers.name = transformation.item_number
        AND subprojects.name = transformation.subproject
;
