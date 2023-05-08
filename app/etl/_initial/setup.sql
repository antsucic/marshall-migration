CREATE SCHEMA IF NOT EXISTS staging;
CREATE SCHEMA IF NOT EXISTS transform;

ALTER TABLE public.companies
    DROP COLUMN IF EXISTS legacy_id
    , ADD COLUMN IF NOT EXISTS legacy_ids TEXT[] DEFAULT '{}'
    , ADD COLUMN IF NOT EXISTS legacy_source VARCHAR(100)
;

ALTER TABLE public.documents
    DROP COLUMN IF EXISTS legacy_id
    , ADD COLUMN IF NOT EXISTS legacy_ids TEXT[] DEFAULT '{}'
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

-- TODO: Remove project duplicates -- ONETIME FIX -- Remove after initial run!
DELETE FROM
    public.projects
USING public.facilities
    WHERE projects.legacy_id = facilities.legacy_id
    AND projects.legacy_source = facilities.legacy_source
;
