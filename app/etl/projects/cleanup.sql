-- Remove project duplicates
DELETE FROM
    public.projects
USING public.facilities
    WHERE projects.legacy_id = facilities.legacy_id
    AND projects.legacy_source = facilities.legacy_source
;
