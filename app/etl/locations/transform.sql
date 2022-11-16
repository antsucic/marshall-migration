INSERT INTO transform.locations
(
    legacy_id
    , address
    , city
    , state
    , postal_code
    , country
    , created_at
    , updated_at
)
SELECT
    legacy_id
     , TRIM(CASE WHEN address_2 IS NOT NULL THEN address_1 || ', ' || address_2 ELSE address_1 END)
     , city
     , region
     , postal_code
     , 'US'
     , created_at
     , updated_at
FROM
    staging.locations
;
