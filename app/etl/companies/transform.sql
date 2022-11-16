INSERT INTO transform.companies
(
    legacy_id
    , legacy_user_id
    , legacy_location_id
    , "name"
    , phone
    , status
    , created_at
    , updated_at
)
SELECT
    legacy_id
    , legacy_user_id
    , legacy_location_id
    , "name"
    , phone
    , CASE status
        WHEN '2' THEN 'active'
        ELSE 'inactive'
    END
    , NOW()
    , NOW()
FROM
    staging.companies
;
