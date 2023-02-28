DROP TABLE IF EXISTS staging.documents;
DROP TABLE IF EXISTS staging.document_subprojects;
DROP TABLE IF EXISTS staging.document_revision_numbers;
DROP TABLE IF EXISTS staging.document_disciplines;
DROP TABLE IF EXISTS staging.document_numbers;
DROP TABLE IF EXISTS transform.documents;
DROP TABLE IF EXISTS transform.document_revisions;

CREATE TABLE staging.documents (
    legacy_id VARCHAR
    , legacy_folder_id VARCHAR(36)
    , legacy_documentable_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , "name" VARCHAR
    , status VARCHAR
    , description VARCHAR
    , document_type VARCHAR
    , is_not_old VARCHAR
    , file_path VARCHAR
    , file_name VARCHAR
    , created_at TIMESTAMP(6) NOT NULL
    , updated_at TIMESTAMP(6) NOT NULL
);

CREATE TABLE staging.document_subprojects (
    legacy_id VARCHAR
    , legacy_source VARCHAR(100)
    , "name" VARCHAR
);

CREATE TABLE staging.document_revision_numbers (
    legacy_id VARCHAR
    , legacy_source VARCHAR(100)
    , "name" VARCHAR
);

CREATE TABLE staging.document_disciplines (
    legacy_id VARCHAR
    , legacy_source VARCHAR(100)
    , "name" VARCHAR
);

CREATE TABLE staging.document_numbers (
    legacy_id VARCHAR
    , legacy_source VARCHAR(100)
    , "name" VARCHAR
);

CREATE TABLE transform.documents (
    id SERIAL PRIMARY KEY
    , legacy_documentable_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , item_number VARCHAR
    , status VARCHAR
    , document_type VARCHAR
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
    , subproject VARCHAR
);

CREATE TABLE transform.document_revisions (
    document_id BIGINT
    , legacy_id VARCHAR(36)
    , legacy_folder_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , legacy_path VARCHAR
    , legacy_filename VARCHAR
    , "name" VARCHAR
    , status VARCHAR
    , description VARCHAR
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
    , revision VARCHAR
    , discipline VARCHAR
    , is_old BOOLEAN
);

TRUNCATE TABLE public.documents RESTART IDENTITY CASCADE;
TRUNCATE TABLE public.document_revisions RESTART IDENTITY CASCADE;

ALTER TABLE public.documents
    ADD COLUMN IF NOT EXISTS legacy_id BIGINT
;

ALTER TABLE public.document_revisions
    ADD COLUMN IF NOT EXISTS legacy_id VARCHAR(36)
    , ADD COLUMN IF NOT EXISTS legacy_source VARCHAR(100)
    , ADD COLUMN IF NOT EXISTS legacy_path VARCHAR
    , ADD COLUMN IF NOT EXISTS legacy_filename VARCHAR
;
