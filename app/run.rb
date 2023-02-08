require_relative 'lib'
require 'pg'

begin
  connection = PG::Connection.new(**connection_parameters)

  Dir.glob("**/companies/setup.sql") { |path| run_script(connection, path) }

  clients.each do |client|
    Dir.glob("**/companies/extract.sql.txt") { |path| run_extraction_script(connection, path, client) }
  end

  Dir.glob("**/companies/transform.sql") { |path| run_script(connection, path) }
  load_priority.each { |entity| run_script(connection, "app/etl/#{entity}/load.sql") }
  #Dir.glob("**/cleanup.sql") { |path| run_script(connection, path) }

rescue PG::Error => error
  puts error.message

ensure
  connection.close if connection
end
