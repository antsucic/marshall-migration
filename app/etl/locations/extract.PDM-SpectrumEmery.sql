INSERT INTO staging.locations
(
    legacy_facility_id
    , legacy_source
    , address_1
    , address_2
    , city
    , region
    , postal_code
)
SELECT
    products."Id"
    , 'PDM-SpectrumEmery'
    , adresses."Attr_Value"
    , numbers."Attr_Value"
    , cities."Attr_Value"
    , regions."Attr_Value"
    , codes."Attr_Value"
FROM
    "PDM-SpectrumEmery"."Products" products
    JOIN "PDM-SpectrumEmery"."Owners" owners
        ON products."Owner_Id" = owners."Id"
    JOIN "PDM-SpectrumEmery"."Companies" companies
        ON owners."Company_Id" = companies."Id"
    LEFT JOIN "PDM-SpectrumEmery"."Attribute_Values" adresses
        ON products."Id" = adresses."Object_Id"
        AND adresses."Attribute_Id" = 'SYS_ATTR300'
    LEFT JOIN "PDM-SpectrumEmery"."Attribute_Values" numbers
        ON products."Id" = numbers."Object_Id"
        AND numbers."Attribute_Id" = 'SYS_ATTR301'
    LEFT JOIN "PDM-SpectrumEmery"."Attribute_Values" cities
        ON products."Id" = cities."Object_Id"
        AND cities."Attribute_Id" = 'SYS_ATTR302'
    LEFT JOIN "PDM-SpectrumEmery"."Attribute_Values" regions
        ON products."Id" = regions."Object_Id"
        AND regions."Attribute_Id" = 'SYS_ATTR303'
    LEFT JOIN "PDM-SpectrumEmery"."Attribute_Values" codes
        ON products."Id" = codes."Object_Id"
        AND codes."Attribute_Id" = 'SYS_ATTR305'
WHERE
    COALESCE(
        adresses."Attr_Value"
        , numbers."Attr_Value"
        , cities."Attr_Value"
        , regions."Attr_Value"
        , codes."Attr_Value"
    ) IS NOT NULL
;
