INSERT INTO transform.users_legacy
(
    legacy_ids
    , email
    , first_name
    , last_name
    , status
    , "role"
    , created_at
    , updated_at
)
SELECT
    JSON_AGG(
        JSON_BUILD_OBJECT(
            'type', 'user',
            'id', entities.legacy_id,
            'source', entities.legacy_source
        )
        ORDER BY entities.legacy_id, entities.legacy_source
    )
    , entities.email
    , MAX(entities.first_name)
    , MAX(entities.last_name)
    , CASE
        WHEN 2 = ANY(ARRAY_AGG(entities.status::integer)) THEN 'active'
        WHEN 1 = ANY(ARRAY_AGG(entities.status::integer)) THEN 'pending'
        ELSE 'inactive'
    END
    , CASE
        WHEN entities.email LIKE '%@landrco.com' THEN 'admin_assistant'
        WHEN entities.email LIKE '%@lrplot.com' THEN 'admin_assistant'
        WHEN entities.email LIKE '%@lraec.com' THEN 'admin_assistant'
        WHEN MAX(owners.email) IS NOT NULL THEN 'owner'
        ELSE 'organization_user'
    END
    , COALESCE(MIN(entities.created_at), NOW())
    , COALESCE(MAX(entities.updated_at), NOW())
FROM
    staging.entities
    LEFT JOIN staging.owners
        ON entities.email = owners.email
GROUP BY
    entities.email
;

INSERT INTO transform.users_legacy
(
    legacy_ids
    , email
    , first_name
    , last_name
    , status
    , "role"
    , created_at
    , updated_at
)
SELECT
    JSON_AGG(
        JSON_BUILD_OBJECT(
            'type', 'owner',
            'id', owners.legacy_id,
            'source', owners.legacy_source,
            'company_id', owners.legacy_company_id
        )
        ORDER BY owners.legacy_id, owners.legacy_source
    )
    , COALESCE(
        owners.email,
        'followup_' || owners.legacy_id || '@' || COALESCE(
            REGEXP_REPLACE(LOWER(owners.first_name), '[\W\s]+', '', 'g'),
            REGEXP_REPLACE(LOWER(owners.last_name), '[\W\s]+', '', 'g'),
            'empty.com'
        )
    ) owner_email
    , MAX(owners.first_name)
    , MAX(owners.last_name)
    , CASE
        WHEN 2 = ANY(ARRAY_AGG(owners.status::integer)) THEN 'active'
        WHEN 1 = ANY(ARRAY_AGG(owners.status::integer)) THEN 'pending'
        ELSE 'inactive'
    END
    , 'owner'
    , NOW()
    , NOW()
FROM
    staging.owners
    LEFT JOIN staging.entities
        ON owners.email = entities.email
WHERE
    entities.legacy_id IS NULL
GROUP BY
    owner_email
;

INSERT INTO transform.users_production
(
    id
    , email
    , first_name
    , last_name
    , status
    , "role"
    , created_at
    , updated_at
    , legacy_ids
)
SELECT
    id
    , email
    , first_name
    , last_name
    , status
    , "role"
    , created_at
    , updated_at
    , legacy_ids
FROM
    public.users
;
