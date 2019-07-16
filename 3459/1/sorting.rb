# frozen_string_literal: true

# This class sort gems by populatity and gives result.
class Sorting
  attr_reader :result

  def initialize(strings)
    @strings = strings
    @result = []
  end

  def result_sorting
    result = last_string(sort(@strings))
    result.reverse!
  end

  private

  def remove_spaces_and_commas(strings)
    strings.map! do |item|
      item.delete(',').split(' ')
    end
  end

  def sort(strings)
    new_strings = remove_spaces_and_commas(strings)
    new_strings.sort_by! { |item| item[1].to_i }
  end

  def last_string(new_strings)
    new_strings.map! do |item|
      first = "|#{item[0]} \t |used by #{item[1]} \t |watched by  #{item[2]} \t |"
      second = "stars #{item[3]} \t |forks #{item[4]} \t |"
      third = "contributors #{item[5]} \t |issues #{item[6]} \t |"
      first + second + third
    end
  end
end
