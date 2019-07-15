# frozen_string_literal: true

# class Sorter
class Sorter
  attr_reader :result
  def initialize(strings)
    @strings = strings
    @result = []
  end

  def result_sort
    result = sort(@strings)
    result.reverse!
  end

  private

  # rubocop:disable Metrics/AbcSize
  # :reek:UtilityFunction
  def sort(strings)
    strings.map! do |temp|
      temp.delete(',').split(' ')
    end
    strings.sort_by! { |temp| }.map! do |temp|
      temp[0] + "\t | used by " +
        temp[1] + "\t | watched by " + temp[2] + " \t | " +
        temp[3] + ' stars | ' + temp[4] + "\t forks | " +
        temp[5] + "\t contributors | " + temp[6] + "\t issues |"
    end
  end
end
