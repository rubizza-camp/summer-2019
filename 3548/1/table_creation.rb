require 'terminal-table'
require 'octokit'
require_relative './customise_and_output_top'
require_relative 'parser'

class TableCreation
  include CustomiseAndOutputTop

  def initialize(all_gems_top, top_size, contains_in_name)
    @top_size = top_size.to_i
    @contains_in_name = contains_in_name
    @all_gems_top = prepare_top_gems(all_gems_top)
    @table = []
  end
end
