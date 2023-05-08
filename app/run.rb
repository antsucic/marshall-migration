require_relative 'lib'
require 'pg'

begin
  connection = PG::Connection.new(**connection_parameters)

  Dir.glob("**/_initial/setup.sql") { |path| run_script(connection, path) }
  Dir.glob("**/setup.sql") { |path| run_script(connection, path) }

  clients.each { |client| Dir.glob("**/extract.sql.txt") { |path| run_extraction_script(connection, path, client) } }
  Dir.glob("**/extract.*.sql") { |path| run_script(connection, path) }

  Dir.glob("**/transform.sql") { |path| run_script(connection, path) }

  load_priority.each do |entity|
    compare_script = "app/etl/#{entity}/compare.sql"
    cleanup_script = "app/etl/#{entity}/cleanup.sql"

    run_script(connection, compare_script) if File.exists?(compare_script)
    run_script(connection, "app/etl/#{entity}/load.sql")
    run_script(connection, cleanup_script) if File.exists?(cleanup_script)
  end

rescue PG::Error => error
  puts error.message

ensure
  connection.close if connection
end
