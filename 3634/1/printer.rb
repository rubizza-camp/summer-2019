class Printer
  def output(table_header, table_rows)
    show(table_header, table_rows)
  end

  private

  def show(table_header, table_rows)
    rows = []
    table_rows.each { |row| rows << row }
    Terminal::Table.new title: 'TOP GEMS', headings: table_header, rows: rows
  end
end
