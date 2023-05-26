INSERT INTO staging.document_custom_attributes
(
    legacy_id
    , legacy_company_id
    , legacy_source
    , "name"
)
SELECT
    attributes."Id"
    , 'NISSAN_STADIUM'
    , 'PDM-DEMO'
    , attributes."Display_Name"
FROM
    "PDM-DEMO"."Attributes" attributes
WHERE
    attributes."Display_Name" IN (
        'Level'
        , 'Quad'
    )
;
