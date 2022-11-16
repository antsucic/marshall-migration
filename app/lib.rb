def connection_parameters
  {
    host: ENV['DATABASE_HOST'],
    dbname: ENV['DATABASE_NAME'],
    user: ENV['DATABASE_USERNAME'],
    password: ENV['DATABASE_PASSWORD'],
    port: ENV['DATABASE_PORT'],
  }
end

def processes
  [
    :setup,
    :extract,
    :transform,
    :load,
    :cleanup,
  ]
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
  ]
end

def run_script(connection, path)
  puts "     Running #{path} script!"
  connection.exec(File.open(path).read)
end