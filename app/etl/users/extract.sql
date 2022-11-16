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
;
