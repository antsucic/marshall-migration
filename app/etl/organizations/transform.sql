INSERT INTO transform.organizations
(
    "name"
    , created_at
    , updated_at
)
SELECT
    organizations."name"
    , MIN(organizations.created_at)
    , MAX(organizations.updated_at)
FROM
    staging.organizations organizations
GROUP BY
    organizations."name"
;

INSERT INTO transform.organization_aliases
(
    organization_id
    , legacy_id
    , legacy_source
    , legacy_location_id
)
SELECT
    transformation.id
    , legacy_id
    , legacy_source
    , stage.legacy_location_id
FROM
    staging.organizations stage
    LEFT JOIN transform.organizations transformation
        ON stage.name = transformation.name
;
