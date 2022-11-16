INSERT INTO staging.locations
(
    legacy_id
    , address_1
    , address_2
    , city
    , region
    , postal_code
    , created_at
    , updated_at
)
SELECT
    locations."Id"
    , locations."Address1"
    , locations."Address2"
    , locations."City"
    , locations."Region"
    , locations."Postal_Code"
    , locations."Last_Edit_DateTime"
    , locations."Last_Edit_DateTime"
FROM
    legacy."Locations" locations
;
