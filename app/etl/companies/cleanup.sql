ALTER TABLE public.companies
    DROP COLUMN IF EXISTS legacy_id
    , DROP COLUMN IF EXISTS legacy_user_id
    , DROP COLUMN IF EXISTS legacy_location_id
;
