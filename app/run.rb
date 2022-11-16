require_relative 'lib'
require 'pg'

begin
  connection = PG::Connection.new(**connection_parameters)

  processes.each do |process|
    puts "[[[ Starting #{process} process ]]]"

    load_priority.each { |entity| run_script(connection, "app/etl/#{entity}/load.sql") } if process == :load
    next if process == :load

    Dir.glob("**/#{process}.sql") do |path|
      run_script(connection, path)
    end

    puts "[[[ #{process.capitalize} process finished ]]]"
  end

rescue PG::Error => error
  puts error.message

ensure
  connection.close if connection
end
