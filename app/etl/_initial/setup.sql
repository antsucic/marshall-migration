CREATE SCHEMA IF NOT EXISTS staging;
CREATE SCHEMA IF NOT EXISTS transform;

ALTER TABLE public.companies
    DROP COLUMN IF EXISTS legacy_id
    , DROP COLUMN IF EXISTS legacy_ids
    , DROP COLUMN IF EXISTS legacy_source
    , ADD COLUMN IF NOT EXISTS legacy_sources JSONB DEFAULT '[]'
;

ALTER TABLE public.documents
    DROP COLUMN IF EXISTS legacy_id
    , ADD COLUMN IF NOT EXISTS legacy_ids TEXT[] DEFAULT '{}'
    , ADD COLUMN IF NOT EXISTS legacy_source VARCHAR(100)
;

ALTER TABLE public.document_custom_attributes
    ADD COLUMN IF NOT EXISTS legacy_id VARCHAR(36)
    , ADD COLUMN IF NOT EXISTS legacy_source VARCHAR(100)
;

ALTER TABLE public.organizations
    DROP COLUMN IF EXISTS legacy_id
    , ADD COLUMN IF NOT EXISTS legacy_ids JSONB DEFAULT '[]'
;

ALTER TABLE public.projects
    DROP COLUMN IF EXISTS legacy_facility_id
;

ALTER TABLE public.users
    DROP COLUMN IF EXISTS legacy_id
    , DROP COLUMN IF EXISTS legacy_owner_id
    , ADD COLUMN IF NOT EXISTS legacy_ids JSONB DEFAULT '[]'
;

CREATE INDEX IF NOT EXISTS index_facilities_legacy_id ON public.facilities (legacy_id);
CREATE INDEX IF NOT EXISTS index_facilities_legacy_source ON public.facilities (legacy_source);
CREATE INDEX IF NOT EXISTS index_projects_legacy_id ON public.projects (legacy_id);
CREATE INDEX IF NOT EXISTS index_projects_legacy_source ON public.projects (legacy_source);
CREATE INDEX IF NOT EXISTS index_folders_legacy_id ON public.folders (legacy_id);
CREATE INDEX IF NOT EXISTS index_folders_legacy_source ON public.folders (legacy_source);

