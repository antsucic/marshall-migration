require_relative 'lib'
require 'pg'

begin
  connection = PG::Connection.new(**connection_parameters)

  clients.each do |client|
    connection.exec("CREATE SCHEMA IF NOT EXISTS \"#{client}\"")
  end

rescue PG::Error => error
  puts error.message

ensure
  connection.close if connection
end
