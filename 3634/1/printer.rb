class Printer
  def output(header, rows)
    show(header, rows)
  end

  private

  def show(header, rows)
    Terminal::Table.new title: 'TOP GEMS', headings: header, rows: rows,
                        style: { alignment: :center }
  end
end
