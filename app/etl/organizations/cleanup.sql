ALTER TABLE public.organizations
    DROP COLUMN IF EXISTS legacy_ids
    , DROP COLUMN IF EXISTS legacy_source
    , DROP COLUMN IF EXISTS legacy_location_ids
;
