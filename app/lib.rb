require_relative 'import_tables'

def connection_parameters
  {
    host: ENV['DATABASE_HOST'],
    dbname: ENV['DATABASE_NAME'],
    user: ENV['DATABASE_USERNAME'],
    password: ENV['DATABASE_PASSWORD'],
    port: ENV['DATABASE_PORT'],
  }
  end

def legacy_connection_parameters(database:)
  {
    host: ENV['LEGACY_DATABASE_HOST'],
    database: database,
    username: ENV['LEGACY_DATABASE_USERNAME'],
    password: ENV['LEGACY_DATABASE_PASSWORD'],
    port: ENV['LEGACY_DATABASE_PORT'],
  }
end

def load_priority
  [
    :users,
    :organizations,
    :locations,
    :companies,
    :locations_users,
    :locations_organizations,
    :companies_users,
    :facilities,
    :projects,
    :folders,
    :documents,
  ]
end

def clients
  %w[
    PDM-BWSC
    PDM-CCA
    PDM-CHS
    PDM-DEMO
    PDM-ESA
    PDM-HRT
    PDM-LifePoint
    PDM-LRPLOT
    PDM-MNPS
    PDM-Quorum
    PDM-SpectrumEmery
  ]
end

def source_tables
  %w[
    Attribute_Values
    Attributes
    Companies
    Components
    Entities
    Folder_Child_Folders
    Folder_Contents
    Folders
    Items
    Locations
    Organizations
    Owners
    Product_Items
    Products
    Vault_Entries
  ]
end

def run_script(connection, path)
  puts "     #{Time.now}: Running #{path} script!"
  connection.exec(File.open(path).read)
end

def run_extraction_script(connection, path, source)
  puts "     #{Time.now}: Running #{path} script! Source: #{source}"
  query = File.open(path).read.gsub('"', '\"')
  connection.exec(eval("\"#{query}\""))
end
