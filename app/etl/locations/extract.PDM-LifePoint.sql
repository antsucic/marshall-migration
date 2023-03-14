CREATE INDEX IF NOT EXISTS object_id_idx ON "PDM-LifePoint"."Attribute_Values" ("Object_Id");
CREATE INDEX IF NOT EXISTS object_id_attr_id_idx ON "PDM-LifePoint"."Attribute_Values" ("Object_Id", "Attribute_Id");

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
     , 'PDM-LifePoint'
     , MAX(
        CASE WHEN "PDM-LifePoint"."Attribute_Values"."Attribute_Id" = 'SYS_ATTR300' THEN "Attr_Value" END
    ) AS address_1
     , MAX(
        CASE WHEN "PDM-LifePoint"."Attribute_Values"."Attribute_Id" = 'SYS_ATTR301' THEN "Attr_Value" END
    ) AS address_2
     , MAX(
        CASE WHEN "PDM-LifePoint"."Attribute_Values"."Attribute_Id" = 'SYS_ATTR302' THEN "Attr_Value" END
    ) AS city
     , MAX(
        CASE WHEN "PDM-LifePoint"."Attribute_Values"."Attribute_Id" = 'SYS_ATTR303' THEN "Attr_Value" END
    ) AS region
     , MAX(
        CASE WHEN "PDM-LifePoint"."Attribute_Values"."Attribute_Id" = 'SYS_ATTR305' THEN "Attr_Value" END
    ) AS postal_code
     , NOW()
     , NOW()
FROM
    "PDM-LifePoint"."Attribute_Values"
GROUP BY
    "PDM-LifePoint"."Attribute_Values"."Object_Id";

SET search_path = "PDM-LifePoint";
DROP INDEX IF EXISTS object_id_idx;
DROP INDEX IF EXISTS object_id_attr_id_idx;