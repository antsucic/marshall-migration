require_relative 'lib'
require 'pg'
require 'table_print'

begin
  connection = PG::Connection.new(**connection_parameters)

  tables = {}
  load_priority.each do |entity|
    tables[entity] = {}

    %w[added updated].each do |action|
      table = "#{entity}_production_#{action}"
      if table_exists(connection, 'transform', table)
        query = "SELECT COUNT(*) FROM transform.#{table}"
        result = connection.exec(query)
        tables[entity][action] = result.first['count']
      end
    end
  end

  report = []
  tables.each do |table, actions|
    report << {
      TABLE: table,
      ADDED: actions['added'],
      UPDATED: actions['updated'],
    }
  end

  tp report

rescue PG::Error => error
  puts error.message

ensure
  connection.close if connection
end
