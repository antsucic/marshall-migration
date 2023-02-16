INSERT INTO transform.folders
(
    legacy_id
    , legacy_folderable_id
    , legacy_parent_id
    , legacy_source
    , "name"
    , created_at
    , updated_at
)
SELECT
    legacy_id
    , legacy_folderable_id
    , legacy_parent_id
    , legacy_source
    , "name"
    , COALESCE(created_at, NOW())
    , COALESCE(created_at, NOW())
FROM
    staging.folders
;
