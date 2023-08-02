INSERT INTO transform.folders_legacy
(
    legacy_id
    , legacy_folderable_id
    , legacy_parent_id
    , legacy_source
    , "name"
    , hidden
    , created_at
    , updated_at
)
SELECT
    legacy_id
    , legacy_folderable_id
    , legacy_parent_id
    , legacy_source
    , "name"
    , (status::integer != 2)
    , COALESCE(created_at, NOW())
    , COALESCE(created_at, NOW())
FROM
    staging.folders
;

INSERT INTO transform.folders_production
(
    id
    , parent_id
    , name
    , hidden
    , created_at
    , updated_at
    , folderable_type
    , folderable_id
    , legacy_id
    , legacy_source
)
SELECT
    id
     , parent_id
     , name
     , hidden
     , created_at
     , updated_at
     , folderable_type
     , folderable_id
     , legacy_id
     , legacy_source
FROM
    public.folders
;
