puts "RELOADING DATA FROM LEGACY"
require "./app/reload.rb"

puts "RUNNING ETL PROCESS"
require "./app/run.rb"

puts "FINISHED ETL PROCESS"
