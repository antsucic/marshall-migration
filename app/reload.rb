require_relative 'lib'
require 'fileutils'

source_host = ENV['SOURCE_DATABASE_HOST']
source_user = ENV['SOURCE_DATABASE_USERNAME']
source_pass = ENV['SOURCE_DATABASE_PASSWORD']

target_host = ENV['DATABASE_HOST']
target_port = ENV['DATABASE_PORT']
target_user = ENV['DATABASE_USERNAME']
target_pass = ENV['DATABASE_PASSWORD']
target_name = ENV['DATABASE_NAME']

clients.each do |client|
  path = "dump/#{client}"
  FileUtils.mkdir_p(path) unless File.exists?(path)

  import_tables.each do |table, columns|
    puts "\n"

    file = "#{path}/#{table}.csv"
    query = "SET NOCOUNT ON;SELECT #{columns.values.join(', ')} FROM #{table}"

    print "EXPORTING #{client}.#{table} to #{file}\r"

    system("/opt/mssql-tools/bin/sqlcmd -S '#{source_host}' -U '#{source_user}' -P '#{source_pass}' -d '#{client}' -Q '#{query}' -o '#{file}' -h-1 -s'\t' -w 65535 -W")

    psql_command = "PGPASSWORD=#{target_pass} PGOPTIONS=\"--search_path='#{client}'\" psql -h #{target_host} -p #{target_port} -U #{target_user} -d #{target_name}"

    puts "CLEARING #{client}.#{table}".ljust(100)
    truncate_command = "'TRUNCATE \"#{client}\".\"#{table}\" CASCADE'"
    system("#{psql_command} -c #{truncate_command} >/dev/null")

    puts "RELOADING #{client}.#{table}".ljust(100)
    copy_options = "(FORMAT 'csv', QUOTE E'\v', DELIMITER E'\t', NULL 'NULL', ENCODING 'UTF-8')"
    copy_target = "\\\"#{client}\\\".\\\"#{table}\\\" (\\\"#{columns.keys.join('\", \"')}\\\")"
    copy_command = "\"\\COPY #{copy_target} FROM #{file} #{copy_options}\""
    system("#{psql_command} -c #{copy_command} >/dev/null")

    puts "RELOADED #{client}.#{table}".ljust(100)
  end

  system("rm -rf #{path}")
end
