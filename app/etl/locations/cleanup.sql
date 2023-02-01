ALTER TABLE public.locations
    DROP COLUMN IF EXISTS legacy_id
    , DROP COLUMN IF EXISTS legacy_source
;
