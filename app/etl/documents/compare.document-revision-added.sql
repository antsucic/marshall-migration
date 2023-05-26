INSERT INTO transform.document_attributes
(
    legacy_id
    , legacy_source
    , value
)
SELECT
    legacy.legacy_id
    , legacy.legacy_source
    , JSON_OBJECT_AGG(
        production.id, legacy.value
    )
FROM
    staging.document_attributes legacy
    JOIN staging.document_types types
        ON legacy.legacy_id = types.legacy_id
        AND legacy.legacy_source = types.legacy_source
    JOIN public.document_custom_attributes production
        ON legacy.legacy_attribute_id = production.legacy_id
        AND legacy.legacy_source = production.legacy_source
        AND types.value = production.document_type
GROUP BY
    legacy.legacy_id,
    legacy.legacy_source
;

UPDATE
    transform.document_revisions_legacy revisions
SET
    document_attributes = document_attributes || attributes.value
FROM
    transform.document_attributes attributes
WHERE
    revisions.legacy_id = attributes.legacy_id
    AND revisions.legacy_source = attributes.legacy_source
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
