# frozen_string_literal: true

require './git_parser'

class GemInfo
  include GitParser
  COEFFICIENTS = { used: 1, watch: 7, star: 15, fork: 20, contributor: 5, issue: 1 }.freeze

  attr_reader :name

  def rank
    COEFFICIENTS.sum { |key, coeff| params[key] * coeff }
  end

  def params
    @params ||= parse(@link)
  end

  def initialize(git, gem)
    @link = git
    @name = gem
  end
end
