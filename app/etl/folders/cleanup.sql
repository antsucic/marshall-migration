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

-- YAY manual recursion!!! Always wanted to make one of these!
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

DROP VIEW public.empty_folders;
