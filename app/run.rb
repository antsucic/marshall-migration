require 'pg'

begin
  parameters = {
    host: ENV['DATABASE_HOST'],
    dbname: ENV['DATABASE_NAME'],
    user: ENV['DATABASE_USERNAME'],
    password: ENV['DATABASE_PASSWORD'],
    port: ENV['DATABASE_PORT'],
  }

  connection = PG::Connection.new(**parameters)

  processes = %w[extract transform load]
  processes.each do |process|
    puts "[[[ Starting #{process} process ]]]"
    Dir.glob("**/#{process}.sql") do |path|
      puts "-----> Running #{path} script!"
      connection.exec(File.open(path).read)
    end

    puts "[[[ #{process.capitalize} process finished ]]]"
  end

rescue PG::Error => error
  puts error.message

ensure
  connection.close if connection
end