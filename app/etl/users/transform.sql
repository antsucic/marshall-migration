INSERT INTO transform.users
(
    email
    , first_name
    , last_name
    , status
    , "role"
    , created_at
    , updated_at
)
SELECT
    users.email
    , MAX(users.first_name)
    , MAX(users.last_name)
    , CASE
        WHEN 2 = ANY(ARRAY_AGG(users.status::integer)) THEN 'active'
        WHEN 1 = ANY(ARRAY_AGG(users.status::integer)) THEN 'pending'
        ELSE 'inactive'
    END
    , CASE
        WHEN MAX(owners.legacy_id) IS NOT NULL THEN 'owner'
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
        ON users.email = owners.email
WHERE
    owners.legacy_id IS NULL
GROUP BY
    users.email
;

INSERT INTO transform.owners
(
    email
    , first_name
    , last_name
    , status
    , "role"
    , created_at
    , updated_at
)
SELECT
    COALESCE(
        email,
        CONCAT('followup_',
            legacy_id,
            '@',
            COALESCE(
                REGEXP_REPLACE(LOWER(first_name), '[^\w]+', ''),
                REGEXP_REPLACE(LOWER(last_name), '[^\w]+', ''),
                'empty.com'
            )
        )
    ) owner_email
    , MAX(first_name)
    , MAX(last_name)
    , CASE
        WHEN 2 = ANY(ARRAY_AGG(status::integer)) THEN 'active'
        WHEN 1 = ANY(ARRAY_AGG(status::integer)) THEN 'pending'
        ELSE 'inactive'
    END
    , 'owner'
    , NOW()
    , NOW()
FROM
    staging.owners
GROUP BY
    owner_email
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
    JOIN transform.users transformation
        ON stage.email = transformation.email
;

INSERT INTO transform.owner_aliases
(
    owner_id
    , legacy_id
    , legacy_source
    , legacy_company_id
)
SELECT
    transformation.id
    , legacy_id
    , legacy_source
    , legacy_company_id
FROM
    staging.owners stage
    JOIN transform.owners transformation
        ON stage.email = COALESCE(
            transformation.email,
            CONCAT(
                REGEXP_REPLACE(LOWER(transformation.first_name), '[^\w]+', ''),
                '.',
                REGEXP_REPLACE(LOWER(transformation.last_name), '[^\w]+', ''),
                '@company.com'
            )
        )
;
