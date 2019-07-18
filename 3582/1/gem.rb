# frozen_string_literal: true

require './parse_github'

# This class contains info about single gem
class Gemi
  attr_reader :gem_name, :params, :rank

  def initialize(gem_name)
    @gem_name = gem_name
    @params = parser.fun
    stringify_params
    @rank = count_rank
  end

  private

  def stringify_params
    @params.each { |to_s| }
  end

  def parser
    ParseGithub.new(gem_name)
  end

  def count_rank
    @rank = params[:stars].to_i + params[:watchers].to_i
  end
end
