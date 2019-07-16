require_relative 'sorted_pages'

class RepresentPages
  attr_reader :rows

  def initialize(rows)
    @rows = rows
  end

  def call(option = nil)
    if option
      sort_by_number(option) if option.is_a? Integer 
      sort_by_name(option) if option.is_a? String
      represent_info
    else
      represent_info
    end
  end

  private

  def sort_by_number(number)
    @rows = @rows.first(number) if number.positive?
  end

  def sort_by_name(name)
    @rows.map do |row|
      if row.first.include?(name)
        @rows = []
        @rows << row
      end
    end
  end

  def represent_info
    puts Terminal::Table.new rows: rows
  end
end
