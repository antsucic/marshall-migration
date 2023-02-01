ALTER TABLE public.facilities
    DROP COLUMN IF EXISTS legacy_id
    , DROP COLUMN IF EXISTS legacy_source
;
