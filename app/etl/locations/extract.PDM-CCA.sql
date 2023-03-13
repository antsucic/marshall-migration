CREATE INDEX IF NOT EXISTS object_id_idx ON "PDM-CCA"."Attribute_Values" ("Object_Id");
CREATE INDEX IF NOT EXISTS object_id_attr_id_idx ON "PDM-CCA"."Attribute_Values" ("Object_Id", "Attribute_Id");

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
    'PDM-CCA',
    max(av_address."Attr_Value") addres1,
    max(av_address_2."Attr_Value") addres2,
    max(av_city."Attr_Value") city,
    max(av_state."Attr_Value") region,
    max(av_postal_code."Attr_Value") postal_code,
    now(),
    now()
FROM
    "PDM-CCA"."Attribute_Values" av
        INNER JOIN "PDM-CCA"."Attribute_Values" av_address
                   ON av."Object_Id" = av_address."Object_Id"
                       AND av_address."Attribute_Id" = 'SYS_ATTR346'
        INNER JOIN "PDM-Quorum"."Attribute_Values" av_address_2
                   ON av."Object_Id" = av_address_2."Object_Id"
                       AND av_address_2."Attribute_Id" = 'SYS_ATTR301'
        INNER JOIN "PDM-CCA"."Attribute_Values" av_city
                   ON av."Object_Id" = av_city."Object_Id"
                       AND av_city."Attribute_Id" = 'SYS_ATTR348'
        INNER JOIN "PDM-CCA"."Attribute_Values" av_state
                   ON av."Object_Id" = av_state."Object_Id"
                       AND av_state."Attribute_Id" = 'SYS_ATTR349'
        INNER JOIN "PDM-CCA"."Attribute_Values" av_postal_code
                   ON av."Object_Id" = av_postal_code."Object_Id"
                       AND av_postal_code."Attribute_Id" = 'SYS_ATTR350'
GROUP BY av."Object_Id";

SET search_path = "PDM-CCA";
DROP INDEX IF EXISTS object_id_idx;
DROP INDEX IF EXISTS object_id_attr_id_idx;