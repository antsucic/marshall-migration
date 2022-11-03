require 'pg'

begin
  parameters = {
    host: ENV['DATABASE_HOST'],
    dbname: ENV['DATABASE_NAME'],
    user: ENV['DATABASE_USERNAME'],
    password: ENV['DATABASE_PASSWORD'],
    port: ENV['DATABASE_PORT'],
  }

  # Initialize connection object.
  connection = PG::Connection.new(**parameters)
  puts 'Successfully created connection to database'

  # Run query
  connection.exec('DROP TABLE IF EXISTS inventory;')
  puts 'Finished dropping table (if existed).'

rescue PG::Error => error
  puts error.message

ensure
  connection.close if connection
end