INSERT INTO transform.facilities_legacy
(
    legacy_id
    , legacy_source
    , legacy_company_id
    , legacy_thumbnail_id
    , "name"
    , facility_type
    , status
    , created_at
    , updated_at
)
SELECT
    legacy_id
    , legacy_source
    , legacy_company_id
    , legacy_thumbnail_id
    , LTRIM("name", '_')
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
