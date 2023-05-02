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
    , legacy_revisions
)
SELECT
    documents.legacy_documentable_id
    , documents.legacy_source
    , numbers.value
    , CASE WHEN 2 = ANY(ARRAY_AGG(documents.status::integer)) THEN 'active' ELSE 'inactive' END
    , types.value
    , MIN(documents.created_at)
    , MAX(documents.updated_at)
    , subprojects.value
    , ARRAY_AGG(documents.legacy_id)
FROM
    staging.documents
    LEFT JOIN staging.document_numbers numbers
        ON documents.legacy_id = numbers.legacy_id
    LEFT JOIN staging.document_subprojects subprojects
        ON documents.legacy_id = subprojects.legacy_id
    JOIN staging.document_types types
        ON documents.legacy_id = types.legacy_id
GROUP BY
    documents.legacy_documentable_id
    , documents.legacy_source
    , types.value
    , numbers.value
    , subprojects.value
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
    , document_attributes
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
    , CONCAT(
        CASE WHEN stage.file_source = 2 THEN 'LL_WS2012_LOCAL/' ELSE '' END,
        RTRIM(RTRIM(RTRIM(stage.file_path, stage.file_name), '\'), '/')
    )
    , stage.file_name
    , stage.name
    , CASE WHEN stage.status::integer = 2 THEN 'active' ELSE 'inactive' END
    , stage.description
    , JSONB '{}'
        || CASE WHEN issue_dates.value IS NULL THEN JSONB '{}' ELSE JSONB_BUILD_OBJECT('issue_date', issue_dates.value) END
        || CASE WHEN issue_names.value IS NULL THEN JSONB '{}' ELSE JSONB_BUILD_OBJECT('issue_name', issue_names.value) END
    , stage.created_at
    , stage.updated_at
    , revisions.value
    , disciplines.new_value
    , NOT stage.is_not_old::boolean
FROM
    staging.documents stage
    LEFT JOIN staging.document_disciplines legacy_disciplines
        ON stage.legacy_id = legacy_disciplines.legacy_id
    LEFT JOIN staging.document_discipline_map disciplines
        ON legacy_disciplines.value = disciplines.legacy_value
    LEFT JOIN staging.document_revision_numbers revisions
        ON stage.legacy_id = revisions.legacy_id
    LEFT JOIN staging.document_issue_names issue_names
        ON stage.legacy_id = issue_names.legacy_id
    LEFT JOIN staging.document_issue_dates issue_dates
        ON stage.legacy_id = issue_dates.legacy_id
    JOIN transform.documents transformation
        ON stage.legacy_id = ANY(transformation.legacy_revisions)
        AND stage.legacy_source = transformation.legacy_source
;
