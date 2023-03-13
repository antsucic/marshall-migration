CREATE INDEX IF NOT EXISTS object_id_idx ON "PDM-MNPS"."Attribute_Values" ("Object_Id");
CREATE INDEX IF NOT EXISTS object_id_attr_id_idx ON "PDM-MNPS"."Attribute_Values" ("Object_Id", "Attribute_Id");

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
    av."Object_Id",
    'PDM-MNPS',
    max(av_address_1."Attr_Value") addres1,
    max(av_address_2."Attr_Value") addres2,
    max(av_city."Attr_Value") city,
    max(right(av_state."Attr_Value", 2)) region,
    max(av_postal_code."Attr_Value") postal_code,
    now(),
    now()
FROM
    "PDM-MNPS"."Attribute_Values" av
        INNER JOIN "PDM-MNPS"."Attribute_Values" av_address_1
                   ON av."Object_Id" = av_address_1."Object_Id"
                       AND av_address_1."Attribute_Id" = 'SYS_ATTR300'
        INNER JOIN "PDM-Quorum"."Attribute_Values" av_address_2
                   ON av."Object_Id" = av_address_2."Object_Id"
                       AND av_address_2."Attribute_Id" = 'SYS_ATTR301'
        INNER JOIN "PDM-MNPS"."Attribute_Values" av_city
                   ON av."Object_Id" = av_city."Object_Id"
                       AND av_city."Attribute_Id" = 'SYS_ATTR302'
        INNER JOIN "PDM-MNPS"."Attribute_Values" av_state
                   ON av."Object_Id" = av_state."Object_Id"
                       AND av_state."Attribute_Id" = 'SYS_ATTR303'
        INNER JOIN "PDM-MNPS"."Attribute_Values" av_postal_code
                   ON av."Object_Id" = av_postal_code."Object_Id"
                       AND av_postal_code."Attribute_Id" = 'SYS_ATTR305'
GROUP BY av."Object_Id";

SET search_path = "PDM-MNPS";
DROP INDEX IF EXISTS object_id_idx;
DROP INDEX IF EXISTS object_id_attr_id_idx;