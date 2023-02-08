def connection_parameters
  {
    host: ENV['DATABASE_HOST'],
    dbname: ENV['DATABASE_NAME'],
    user: ENV['DATABASE_USERNAME'],
    password: ENV['DATABASE_PASSWORD'],
    port: ENV['DATABASE_PORT'],
  }
end

def load_priority
  [
    #:users,
    #:organizations,
    #:locations,
    :companies,
    #:locations_users,
    #:locations_organizations,
    #:companies_users,
    #:facilities,
    #:projects,
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
  ]
end

def run_script(connection, path)
  puts "     Running #{path} script!"
  connection.exec(File.open(path).read)
end

def run_extraction_script(connection, path, source)
  puts "     Running #{path} script! Source: #{source}"
  query = File.open(path).read.gsub('"', '\"')
  connection.exec(eval("\"#{query}\""))
end
