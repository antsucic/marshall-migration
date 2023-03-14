CREATE INDEX IF NOT EXISTS object_id_idx ON "PDM-DEMO"."Attribute_Values" ("Object_Id");
CREATE INDEX IF NOT EXISTS object_id_attr_id_idx ON "PDM-DEMO"."Attribute_Values" ("Object_Id", "Attribute_Id");

INSERT INTO staging.locations
(
    legacy_id
, legacy_source
, address_1
, address_2
, city
, region
, postal_code
, created_at
, updated_at
)
SELECT
    "Object_Id"
     , 'PDM-DEMO'
     , MAX(
        CASE WHEN "PDM-DEMO"."Attribute_Values"."Attribute_Id" = 'SYS_ATTR300' THEN "Attr_Value" END
    ) AS address_1
     , MAX(
        CASE WHEN "PDM-DEMO"."Attribute_Values"."Attribute_Id" = 'SYS_ATTR301' THEN "Attr_Value" END
    ) AS address_2
     , MAX(
        CASE WHEN "PDM-DEMO"."Attribute_Values"."Attribute_Id" = 'SYS_ATTR302' THEN "Attr_Value" END
    ) AS city
     , RIGHT(MAX(CASE WHEN "PDM-DEMO"."Attribute_Values"."Attribute_Id" = 'SYS_ATTR303' THEN "Attr_Value" END), 2)
      AS region
     , MAX(
        CASE WHEN "PDM-DEMO"."Attribute_Values"."Attribute_Id" = 'SYS_ATTR305' THEN "Attr_Value" END
    ) AS postal_code
     , NOW()
     , NOW()
FROM
    "PDM-DEMO"."Attribute_Values"
GROUP BY
    "PDM-DEMO"."Attribute_Values"."Object_Id"
;

SET search_path = "PDM-DEMO";
DROP INDEX IF EXISTS object_id_idx;
DROP INDEX IF EXISTS object_id_attr_id_idx;