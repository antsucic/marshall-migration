CREATE OR REPLACE VIEW transform.check_dates AS
    SELECT
        TO_CHAR(dates.value, 'YYYY-MM') period
    FROM (
        SELECT
            GENERATE_SERIES(
                (SELECT MIN(created_at) FROM transform.documents_legacy)
                , NOW()
                , '1 month'::INTERVAL
            ) value
        ) dates
    ;
;

CREATE OR REPLACE FUNCTION transform.updated_documents_in(_period TEXT)
    RETURNS TABLE (
        id INT
        , item_number VARCHAR
        , status VARCHAR
        , document_type VARCHAR
        , updated_at TIMESTAMP
        , documentable_type VARCHAR
        , documentable_id INT
        , subproject VARCHAR
        , legacy_ids TEXT[]
        , legacy_source VARCHAR(100)
    )
    LANGUAGE SQL AS
$$
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
        ON legacy.legacy_ids && production.legacy_ids
        AND legacy.legacy_source = production.legacy_source
        AND TO_CHAR(production.created_at, 'YYYY-MM') = _period
WHERE
    TO_CHAR(legacy.created_at, 'YYYY-MM') = _period
    AND (
        COALESCE(legacy.item_number, '') <> COALESCE(production.item_number, '')
        OR COALESCE(legacy.status, '') <> COALESCE(production.status, '')
        OR COALESCE(legacy.document_type, '') <> COALESCE(production.document_type, '')
        OR COALESCE(CASE WHEN facilities.id IS NOT NULL THEN 'Facility' ELSE 'Project' END, '') <> COALESCE(production.documentable_type, '')
        OR COALESCE(facilities.id, projects.id, 0) <> COALESCE(production.documentable_id, 0)
        OR COALESCE(legacy.subproject, '') <> COALESCE(production.subproject, '')
        OR legacy.legacy_ids <> production.legacy_ids
    )
$$;

CREATE OR REPLACE PROCEDURE transform.insert_document_updates()
    LANGUAGE SQL AS
$$
DO
$loop$
DECLARE
    _current record;
BEGIN
    FOR _current IN SELECT period FROM transform.check_dates LOOP
        RAISE NOTICE '         Processing date : %', _current.period;
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
        FROM
            transform.updated_documents_in(_current.period)
        ;
    END LOOP;
END;
$loop$
$$;

CALL transform.insert_document_updates();
