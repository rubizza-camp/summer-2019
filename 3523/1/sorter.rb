# frozen_string_literal: true

# This is Sorter class. This class sort gems by populatity and gives result
class Sorter
  attr_reader :result
  def initialize(strings)
    @strings = strings
    @result = []
  end

  def result_sort
    result = result_strings(sort(@strings))
    result.reverse!
  end

  private

  def delete_comma(strings)
    strings.map! do |string|
      string.delete(',').split('  ')
    end
  end

  def sort(strings)
    str = delete_comma(strings)
    str.sort_by! { |string| string[3].to_i }
  end

  def result_strings(str)
    str.map! do |res|
      res.join('|')
    end
  end
end
