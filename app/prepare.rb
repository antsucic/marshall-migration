require_relative 'lib'
require 'pg'

begin
  connection = PG::Connection.new(**connection_parameters)

  clients.each do |client|
    connection.exec("CREATE SCHEMA IF NOT EXISTS \"#{client}\"")

    import_tables.each do |table, columns|
      connection.exec <<-SQL
        DROP TABLE IF EXISTS "#{client}"."#{table}"
      SQL

      column_with_types = columns.keys.map do |column|
        "\"#{column}\" #{column_types(table, column)}"
      end

      connection.exec <<-SQL
        CREATE TABLE "#{client}"."#{table}" (#{column_with_types.join(', ')})
      SQL
    end
  end

rescue PG::Error => error
  puts error.message

ensure
  connection.close if connection
end
