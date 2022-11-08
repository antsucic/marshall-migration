DROP TABLE IF EXISTS transform.users;
CREATE TABLE transform.users (
    legacy_id VARCHAR(50) UNIQUE NOT NULL
    , email VARCHAR (255) UNIQUE NOT NULL
    , first_name VARCHAR (255) NOT NULL
    , last_name VARCHAR (255) NOT NULL
    , status VARCHAR(20)
    , "role" VARCHAR(20)
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
);

INSERT INTO transform.users
(
    legacy_id
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
    , CASE parent_entity_id
        WHEN 'SYS_USERS1' THEN CASE legacy_id
            WHEN 'SYS_USERS1' THEN 'admin'
            ELSE 'owner'
        END
        ELSE 'organization_user'
    END
    , created_at
    , updated_at
FROM
    staging.users
