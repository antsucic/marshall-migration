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
    OR COALESCE(legacy.legacy_path, '') <> COALESCE(production.legacy_path, '')
    OR COALESCE(legacy.legacy_filename, '') <> COALESCE(production.legacy_filename, '')
;
SELECT pid, age(clock_timestamp(), query_start), usename, query
FROM pg_stat_activity
WHERE query != '<IDLE>' AND query NOT ILIKE '%pg_stat_activity%'
ORDER BY query_start desc;
