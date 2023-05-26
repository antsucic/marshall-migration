INSERT INTO staging.companies
(
    legacy_id
    , legacy_source
    , name
    , status
)
SELECT
    REGEXP_REPLACE(UPPER(companies."Attr_Value"), '[\W\s]+', '_', 'g')
    , 'PDM-LRPLOT'
    , companies."Attr_Value"
    , '2'
FROM
    "PDM-LRPLOT"."Attribute_Values" companies
    JOIN "PDM-LRPLOT"."Products" products
        ON companies."Object_Id" = products."Id"
WHERE
    companies."Attribute_Id" = 'SYS_ATTR434'
GROUP BY
    companies."Attr_Value"
;
