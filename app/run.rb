require_relative 'lib'
require 'pg'

begin
  connection = PG::Connection.new(**connection_parameters)

  Dir.glob("**/setup.sql") { |path| run_script(connection, path) }

  clients.each { |client| Dir.glob("**/extract.sql.txt") { |path| run_extraction_script(connection, path, client) } }
  Dir.glob("**/extract.*.sql") { |path| run_script(connection, path) }

  Dir.glob("**/transform.sql") { |path| run_script(connection, path) }

  load_priority.each { |entity| run_script(connection, "app/etl/#{entity}/load.sql") }

rescue PG::Error => error
  puts error.message

ensure
  connection.close if connection
end
