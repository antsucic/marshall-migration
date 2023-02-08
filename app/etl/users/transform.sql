INSERT INTO transform.users
(
    legacy_company_id
    , email
    , first_name
    , last_name
    , status
    , "role"
    , created_at
    , updated_at
)
SELECT
    MAX(owners.legacy_company_id)
    , users.email
    , MAX(users.first_name)
    , MAX(users.last_name)
    , CASE
        WHEN 2 = ANY(ARRAY_AGG(status::integer)) THEN 'active'
        WHEN 1 = ANY(ARRAY_AGG(status::integer)) THEN 'pending'
        ELSE 'inactive'
    END
    , CASE
        WHEN owners.legacy_id IS NOT NULL THEN 'owner'
        WHEN users.email LIKE '%@landrco.com' THEN 'admin_assistant'
        WHEN users.email LIKE '%@lrplot.com' THEN 'admin_assistant'
        WHEN users.email LIKE '%@lraec.com' THEN 'admin_assistant'
        ELSE 'organization_user'
    END
    , COALESCE(MIN(users.created_at), NOW())
    , COALESCE(MAX(users.updated_at), NOW())
FROM
    staging.users
    LEFT JOIN staging.owners
        ON users.legacy_id = owners.legacy_id
        AND users.legacy_source = owners.legacy_source
GROUP BY
    users.email
;

INSERT INTO transform.user_aliases
(
    user_id
    , legacy_id
    , legacy_source
)
SELECT
    transformation.id
    , legacy_id
    , legacy_source
FROM
    staging.users stage
    LEFT JOIN transform.users transformation
        ON stage.email = transformation.email
;
