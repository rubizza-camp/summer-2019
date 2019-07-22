require 'terminal-table'

class Output
  HEADER = %i[name_id used_by watch stars fork issues contributors].freeze

  def call(data)
    rows = create_rows(data)
    table = create_table(data, rows)
    puts table
  end

  private

  def create_rows(data)
    data.each_with_object([]) { |gem, stock| stock << gem.values_at(*HEADER) }
  end

  def create_table(data, rows)
    Terminal::Table.new headings: HEADER, rows: rows unless data.empty?
  end
end
