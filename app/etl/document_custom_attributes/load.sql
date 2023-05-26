INSERT INTO public.document_custom_attributes
(
    company_id
    , name
    , document_type
    , is_required
    , is_deleted
    , created_at
    , updated_at
    , legacy_id
    , legacy_source
)
SELECT
    company_id
     , name
     , document_type
     , is_required
     , is_deleted
     , created_at
     , updated_at
     , legacy_id
     , legacy_source
FROM
    transform.document_custom_attributes_production_added
;
