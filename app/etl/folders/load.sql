UPDATE
    public.folders
SET
    parent_id = updates.parent_id
    , "name" = updates.name
    , hidden = updates.hidden
    , updated_at = updates.updated_at
    , folderable_type = updates.folderable_type
    , folderable_id = updates.folderable_id
FROM
    transform.folders_production_updated updates
WHERE
    folders.id = updates.id
;

INSERT INTO public.folders
(
    parent_id
    , "name"
    , hidden
    , created_at
    , updated_at
    , folderable_type
    , folderable_id
    , legacy_id
    , legacy_source
)
SELECT
    folders.parent_id
    , folders.name
    , folders.hidden
    , folders.created_at
    , folders.updated_at
    , folders.folderable_type
    , folders.folderable_id
    , folders.legacy_id
    , folders.legacy_source
FROM
    transform.folders_production_added folders
;
