ALTER TABLE public.projects
    DROP COLUMN IF EXISTS legacy_id
    , DROP COLUMN IF EXISTS legacy_facility_id
    , DROP COLUMN IF EXISTS legacy_source
;
