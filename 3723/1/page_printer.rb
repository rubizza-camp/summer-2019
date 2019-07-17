require_relative 'sorted_pages'

class PagePrinter
  attr_reader :rows

  def initialize(rows)
    @rows = rows
    @named_rows = []
  end

  def call(option = nil)
    if option
      sort_by_number(option) if option.is_a? Integer
      filter_by_name(option) if option.is_a? String
    else
      print_info(@rows)
    end
  end

  private

  def sort_by_number(number)
    @rows = @rows.first(number) if number.positive?
    print_info(@rows)
  end

  def filter_by_name(name)
    @rows.map do |row|
      @named_rows << row if row.first.include?(name)
    end
    print_info(@named_rows)
  end

  def print_info(rows)
    puts Terminal::Table.new rows: rows
  end
end
