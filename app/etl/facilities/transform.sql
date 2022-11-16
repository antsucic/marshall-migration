INSERT INTO transform.facilities
(
    legacy_id
    , legacy_company_id
    , legacy_location_id
    , legacy_thumbnail_id
    , "name"
    , facility_type
    , status
    , created_at
    , updated_at
)
SELECT
    legacy_id
    , legacy_company_id
    , legacy_location_id
    , legacy_thumbnail_id
    , "name"
    , 'clinic'
    , CASE status
        WHEN '2' THEN 'active'
        ELSE 'inactive'
    END
    , created_at
    , created_at
FROM
    staging.facilities
;
