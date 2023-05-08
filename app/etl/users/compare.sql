INSERT INTO transform.users_production_added
(
    email
    , first_name
    , last_name
    , status
    , "role"
    , created_at
    , updated_at
    , legacy_ids
)
SELECT
    legacy.email
    , legacy.first_name
    , legacy.last_name
    , legacy.status
    , legacy."role"
    , legacy.created_at
    , legacy.updated_at
    , legacy.legacy_ids
FROM
    transform.users_legacy legacy
    LEFT JOIN transform.users_production production
        ON legacy.email = production.email
WHERE
    production.id IS NULL
;

INSERT INTO transform.users_production_updated
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
    production.id
    , legacy.email
    , legacy.first_name
    , legacy.last_name
    , legacy.status
    , legacy.role
    , legacy.created_at
    , legacy.updated_at
    , legacy.legacy_ids
FROM
    transform.users_legacy legacy
    JOIN transform.users_production production
         ON legacy.email = production.email
WHERE
    COALESCE(legacy.email, '') <> COALESCE(production.email, '')
    OR COALESCE(legacy.first_name, '') <> COALESCE(production.first_name, '')
    OR COALESCE(legacy.last_name, '') <> COALESCE(production.last_name, '')
    OR COALESCE(legacy.status, '') <> COALESCE(production.status, '')
    OR COALESCE(legacy.role, '') <> COALESCE(production.role, '')
    OR COALESCE(legacy.legacy_ids::VARCHAR, '') <> COALESCE(production.legacy_ids::VARCHAR, '')
;
