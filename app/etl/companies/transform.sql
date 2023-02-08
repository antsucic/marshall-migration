INSERT INTO transform.companies
(
    "name"
    , phone
    , status
    , created_at
    , updated_at
)
SELECT
    "name"
    , MAX(phone)
    , CASE WHEN 2 = ANY(ARRAY_AGG(status::integer)) THEN 'active' ELSE 'inactive' END
    , NOW()
    , NOW()
FROM
    staging.companies
GROUP BY
    "name"
;

INSERT INTO transform.company_aliases
(
    company_id
    , legacy_id
    , legacy_source
)
SELECT
    transformation.id
    , legacy_id
    , legacy_source
FROM
    staging.companies stage
    LEFT JOIN transform.companies transformation
        ON stage.name = transformation.name
;
