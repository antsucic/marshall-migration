INSERT INTO staging.facilities
(
    legacy_id
    , legacy_company_id
    , legacy_location_id
    , legacy_thumbnail_id
    , "name"
    , facility_type
    , status
    , created_at
)
SELECT
    products."Id"
    , owners."Company_Id"
    , companies."Location_Id"
    , products."Thumbnail_File_Id"
    , products."Display_Name"
    , NULL
    , products."Status"
    , products."Enter_Date"
FROM
    legacy."Products" products
    JOIN legacy."Entities" cs
        ON products."Contact_Entity_Id" = cs."Id"
    JOIN legacy."Entities" companies
        ON cs."Parent_Entity_Id" = companies."Id"
    JOIN legacy."Owners" owners
        ON companies."Login_Name" = owners."Email_Address"
WHERE
    products."Product_Type_Id" <> 'SYS_PRODUCTTYPE_TEMPLATE'
