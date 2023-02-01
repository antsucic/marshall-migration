INSERT INTO transform.organizations
(
    legacy_ids
    , legacy_source
    , legacy_location_ids
    , "name"
    , created_at
    , updated_at
)
SELECT
    STRING_AGG(CONCAT(organizations.legacy_source, ':', organizations.legacy_id), ', ')
    , legacy_source
    , STRING_AGG(CONCAT(organizations.legacy_source, ':', organizations.legacy_location_id), ', ')
    , organizations."name"
    , MIN(organizations.created_at)
    , MIN(organizations.updated_at)
FROM
    staging.organizations organizations
GROUP BY
    organizations."name"
    , organizations."legacy_source"
;
