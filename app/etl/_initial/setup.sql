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
