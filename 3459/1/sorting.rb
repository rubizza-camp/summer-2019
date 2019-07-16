# frozen_string_literal: true

# class Sorting
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

  # :reek:UtilityFunctio
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
      first_add_string = "|#{item[0]} | used by #{item[1]} \t |"
      second_add_string = "watched by  #{item[2]} \t |  stars #{item[3]} \t |"
      third_add_string = "forks #{item[4]} \t | contributors #{item[5]} \t |"
      four_add_string = "issues #{item[6]} \t |"
      first_add_string + second_add_string + third_add_string + four_add_string
    end
  end
end
