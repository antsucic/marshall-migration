INSERT INTO transform.users
(
    legacy_id
    , legacy_source
    , email
    , first_name
    , last_name
    , status
    , "role"
    , created_at
    , updated_at
)
SELECT
    legacy_id
    , legacy_source
    , CASE legacy_id
        WHEN 'SYS_USER1' THEN 'admin@marshall.com'
        ELSE email
    END
    , first_name
    , last_name
    , CASE status
        WHEN '1' THEN 'pending'
        WHEN '2' THEN 'active'
        ELSE 'inactive'
    END
    , CASE
        WHEN parent_entity_id IN ('SYS_USERS1', 'SYS_USERS2') AND legacy_id = parent_entity_id THEN 'admin'
        WHEN parent_entity_id IN ('SYS_USERS1', 'SYS_USERS2') THEN 'owner'
        ELSE 'organization_user'
    END
    , created_at
    , updated_at
FROM
    staging.users
;
