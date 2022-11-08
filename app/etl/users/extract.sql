DROP TABLE IF EXISTS staging.users;
CREATE TABLE staging.users (
    legacy_id VARCHAR
    , email VARCHAR
    , first_name VARCHAR
    , last_name VARCHAR
    , status VARCHAR
    , parent_entity_id VARCHAR
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
);

INSERT INTO staging.users
(
    legacy_id
    , email
    , first_name
    , last_name
    , status
    , parent_entity_id
    , created_at
    , updated_at
)
SELECT
    legacy."Id"
    , legacy."Login_Name"
    , legacy."First_Name"
    , COALESCE(legacy."Last_Name", '')
    , legacy."Status"
    , legacy."Parent_Entity_Id"
    , legacy."Enter_DateTime"
    , legacy."Last_Edit_DateTime"
FROM
    legacy."Entities" legacy