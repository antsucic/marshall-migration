ALTER TABLE public.users
    DROP COLUMN IF EXISTS legacy_id
    , DROP COLUMN IF EXISTS legacy_source
;
