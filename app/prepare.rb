require_relative 'lib'
require 'pg'

begin
  connection = PG::Connection.new(**connection_parameters)

  clients.each do |client|
    connection.exec("CREATE SCHEMA IF NOT EXISTS \"#{client}\"")

    import_tables.each do |table, columns|
      connection.exec <<-SQL
        CREATE TABLE IF NOT EXISTS "#{client}"."#{table}" (
          "#{columns.keys.join('" VARCHAR, "')}" VARCHAR
        )
      SQL
    end
  end

rescue PG::Error => error
  puts error.message

ensure
  connection.close if connection
end
