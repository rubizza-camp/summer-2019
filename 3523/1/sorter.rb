# frozen_string_literal: true

require_relative 'helper'
# This is Sorter class
class Sorter
  include Helper
  attr_reader :result
  def initialize(strings)
    @strings = strings
    @result = []
  end

  def result_sort
    result = result_strings(sort(@strings))
    result.reverse!
  end
end
