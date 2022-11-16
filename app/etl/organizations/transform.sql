INSERT INTO transform.organizations
(
    legacy_ids
    , legacy_location_ids
    , "name"
    , created_at
    , updated_at
)
SELECT
    STRING_AGG(organizations.legacy_id, ', ')
    , STRING_AGG(organizations.legacy_location_id, ', ')
    , organizations."name"
    , MIN(organizations.created_at)
    , MIN(organizations.updated_at)
FROM
    staging.organizations organizations
GROUP BY
    organizations."name"
;
