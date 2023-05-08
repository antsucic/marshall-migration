-- Update folder parent relations since they can't be obtained until ID is assigned on production
UPDATE
    public.folders children
SET
    parent_id = parents.id
FROM
    transform.folders_legacy relations
    JOIN public.folders parents
        ON relations.legacy_parent_id = parents.legacy_id
        AND relations.legacy_source = parents.legacy_source
WHERE
    children.legacy_id = relations.legacy_id
    AND children.legacy_source = relations.legacy_source
    AND children.parent_id IS NULL
;

-- Create a view to find last branch of empty folders
CREATE VIEW public.empty_folders AS
    SELECT
        folders.id
    FROM
        public.folders folders
        LEFT JOIN public.folders subfolders
            ON subfolders.parent_id = folders.id
        LEFT JOIN public.document_revisions revisions
            ON folders.id = revisions.folder_id
    WHERE
        subfolders.id IS NULL
        AND revisions.id IS NULL
;

-- YAY manual recursion!!! Always wanted to make one of these! Remove empty folders.
DELETE FROM public.folders folders USING public.empty_folders empties WHERE folders.id = empties.id;
DELETE FROM public.folders folders USING public.empty_folders empties WHERE folders.id = empties.id;
DELETE FROM public.folders folders USING public.empty_folders empties WHERE folders.id = empties.id;
DELETE FROM public.folders folders USING public.empty_folders empties WHERE folders.id = empties.id;
DELETE FROM public.folders folders USING public.empty_folders empties WHERE folders.id = empties.id;
DELETE FROM public.folders folders USING public.empty_folders empties WHERE folders.id = empties.id;
DELETE FROM public.folders folders USING public.empty_folders empties WHERE folders.id = empties.id;
DELETE FROM public.folders folders USING public.empty_folders empties WHERE folders.id = empties.id;
DELETE FROM public.folders folders USING public.empty_folders empties WHERE folders.id = empties.id;
DELETE FROM public.folders folders USING public.empty_folders empties WHERE folders.id = empties.id;

-- Remove the view
DROP VIEW public.empty_folders;
