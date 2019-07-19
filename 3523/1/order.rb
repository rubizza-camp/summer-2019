# frozen_string_literal: true

require 'pry'
# This is Sorter class. This class sort gems by populatity and gives result
class Order
  attr_reader :result
  def initialize(strings)
    @strings = strings
    @result = []
  end

  def result_sort
    result_strings(sort(@strings))
  end

  private

  def delete_comma(strings)
    strings.map! do |string|
      string.delete(',').split('  ')
    end
  end

  def used_by_num(strings)
    strings.last.split(' ').last.to_i
  end

  def sort(strings)
    str_without_comma = delete_comma(strings)
    str_without_comma.sort_by! { |param_a| -used_by_num(param_a) }
  end

  def result_strings(str)
    str.map! do |res|
      res.join('|')
    end
  end
end
