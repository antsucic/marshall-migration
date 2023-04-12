def import_tables
  {
    Attribute_Values: attribute_values_columns,
    Attributes: attributes_columns,
    Companies: companies_columns,
    Components: components_columns,
    Entities: entities_columns,
    Folder_Child_Folders: folder_child_folders_columns,
    Folder_Contents: folder_contents_columns,
    Folders: folders_columns,
    Items: items_columns,
    Locations: locations_columns,
    Organizations: organizations_columns,
    Owners: owners_columns,
    Product_Items: product_items_columns,
    Products: products_columns,
    Vault_Entries: vault_entries_columns,
  }
end

def attribute_values_columns
  {
    PK_Id: 'PK_Id',
    Attribute_Id: 'Attribute_Id',
    Object_Id: 'Object_Id',
    Attr_Value: replace_newlines('Attr_Value'),
  }
end

def attributes_columns
  {
    Id: 'Id',
    Display_Name: 'Display_Name',
  }
end

def companies_columns
  {
    Id: 'Id',
    Status: 'Status',
    Display_Name: 'Display_Name',
  }
end

def components_columns
  {
    Parent_Id: 'Parent_Id',
    File_Id: 'File_Id',
  }
end

def entities_columns
  {
    Id: 'Id',
    Parent_Entity_Id: 'Parent_Entity_Id',
    Status: 'Status',
    Login_Name: 'Login_Name',
    First_Name: 'First_Name',
    Last_Name: 'Last_Name',
    Work_Phone: 'Work_Phone',
    Cell_Phone: 'Cell_Phone',
    Organization_Id: 'Organization_Id',
    Location_Id: 'Location_Id',
    Last_Edit_DateTime: 'Last_Edit_DateTime',
    Enter_DateTime: 'Enter_DateTime',
  }
end

def folder_child_folders_columns
  {
    Parent_Folder_Id: 'Parent_Folder_Id',
    Child_Folder_Id: 'Child_Folder_Id',
    Root_Folder_Id: 'Root_Folder_Id',
  }
end

def folder_contents_columns
  {
    Folder_Id: 'Folder_Id',
    Object_Id: 'Object_Id',
  }
end

def folders_columns
  {
    Id: 'Id',
    Display_Name: replace_newlines('Display_Name'),
    Create_Date: 'Create_Date',
  }
end

def items_columns
  {
    Id: 'Id',
    Status: 'Status',
    Item_Type_Id: 'Item_Type_Id',
    Display_Name: replace_newlines('Display_Name'),
    Description: replace_newlines('Description'),
    Enter_Date: 'Enter_Date',
    Last_Edit_DateTime: 'Last_Edit_DateTime',
    Is_Current_Version: 'Is_Current_Version',
    Default_Viewable_Format_Id: 'Default_Viewable_Format_Id',
    Default_Printable_Format_Id: 'Default_Printable_Format_Id',
  }
end

def locations_columns
  {
    Id: 'Id',
    Address1: 'Address1',
    Address2: 'Address2',
    City: 'City',
    Region: 'Region',
    Postal_Code: 'Postal_Code',
    Last_Edit_DateTime: 'Last_Edit_DateTime',
  }
end

def organizations_columns
  {
    Id: 'Id',
    Display_Name: replace_newlines('Display_Name'),
    Location_Id: 'Location_Id',
    Last_Edit_DateTime: 'Last_Edit_DateTime',
  }
end

def owners_columns
  {
    Id: 'Id',
    Status: 'Status',
    Company_Id: 'Company_Id',
    Display_Name: 'Display_Name',
    First_Name: 'First_Name',
    Last_Name: 'Last_Name',
    Work_Phone: 'Work_Phone',
    Email_Address: 'Email_Address',
  }
end

def product_items_columns
  {
    Product_Id: 'Product_Id',
    Item_Id: 'Item_Id',
  }
end

def products_columns
  {
    Id: 'Id',
    Status: 'Status',
    Display_Name: 'Display_Name',
    Description: replace_newlines('Description'),
    Owner_Id: 'Owner_Id',
    Enter_Date: 'Enter_Date',
    Thumbnail_File_Id: 'Thumbnail_File_Id',
    Folder_Id: 'Folder_Id',
  }
end

def vault_entries_columns
  {
    Id: 'Id',
    Vault_Directory: 'Vault_Directory',
    Vault_Filename: 'Vault_Filename',
  }
end

def replace_newlines(column)
  "RTRIM(LTRIM(REPLACE(REPLACE(REPLACE(#{column}, CHAR(13), \" \"), CHAR(10), \" \"), CHAR(9), \" \")))"
end
