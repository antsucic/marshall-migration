DELETE FROM
    public.users
WHERE
    legacy_ids = '[]'
    AND email LIKE 'followup_%'
;
