WITH document_types AS (
    SELECT
        UNNEST(ARRAY[
            'DRAWING'
            , 'SPECIFICATION'
            , 'MANUAL_BOOK'
            , 'UPLOADED_FILE'
        ]) name
)
INSERT INTO transform.document_custom_attributes_legacy
(
    legacy_id
    , legacy_company_id
    , legacy_source
    , "name"
    , document_type
    , is_required
    , is_deleted
    , created_at
)
SELECT
    attributes.legacy_id
    , attributes.legacy_company_id
    , attributes.legacy_source
    , attributes.name
    , document_types.name
    , FALSE
    , FALSE
    , NOW()
FROM
    staging.document_custom_attributes attributes
    JOIN document_types ON TRUE
;
