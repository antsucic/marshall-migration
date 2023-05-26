INSERT INTO staging.document_attributes
(
    legacy_id
    , legacy_attribute_id
    , legacy_source
    , "value"
)
SELECT
    values."Object_Id"
    , attributes."Id"
    , 'PDM-DEMO'
    , values."Attr_Value"
FROM
    "PDM-DEMO"."Attributes" attributes
    JOIN "PDM-DEMO"."Attribute_Values" values
        ON attributes."Id" = values."Attribute_Id"
WHERE
    attributes."Display_Name" IN (
        'Level'
        , 'Quad'
    )
;


SELECT
    legacy_id
    , legacy_source
    , COUNT(*)
FROM
    transform.document_revisions_legacy
GROUP BY
    legacy_id
    , legacy_source
HAVING
    COUNT(*) > 1
ORDER BY
    COUNT(*) DESC
