INSERT INTO transform.organizations_legacy
(
    legacy_ids
    , "name"
    , created_at
    , updated_at
)
SELECT
    JSON_AGG(
        JSON_BUILD_OBJECT(
            'id', organizations.legacy_id,
            'source', organizations.legacy_source,
            'location_id', organizations.legacy_location_id
        )
    )
    , organizations."name"
    , MIN(organizations.created_at)
    , MAX(organizations.updated_at)
FROM
    staging.organizations organizations
GROUP BY
    organizations."name"
;

INSERT INTO transform.organizations_production
(
    id
    , "name"
    , created_at
    , updated_at
    , legacy_ids
)
SELECT
    id
     , "name"
     , created_at
     , updated_at
    , legacy_ids
FROM
    public.organizations
;
