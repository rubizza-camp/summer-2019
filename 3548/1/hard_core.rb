require 'terminal-table'
require 'octokit'
require_relative 'parser.rb'

class HardCore
  def initialize(all_gems_top, top_size, contains_in_name)
    top_size ||= all_gems_top.size
    @top_size = top_size.to_i
    @contains_in_name = contains_in_name
    @all_gems_top = prepare_top(all_gems_top)
    @table = []
  end

  def print_top
    sort_and_customise_top
    puts Terminal::Table.new(rows: @table, style: { border_top: false, border_bottom: false })
  end

  private

  def customize_central_top_elements
    @table.last[3] = @table.last[3].to_s + ' stars'
    @table.last[4] = @table.last[4].to_s + ' forks'
  end

  def prepare_top(all_gems_top)
    all_gems_top.sort_by! { |all_gems| - all_gems[:used_by] }
  end

  def customise_top
    customise_top_first_elements
    customize_central_top_elements
    customize_top_last_elements
  end

  def customise_top_first_elements
    @table.last[1] = 'used by ' + @table.last[1].to_s
    @table.last[2] = 'watched by ' + @table.last[2].to_s
  end

  def create_new_position_in_top(all_gems)
    fields = %i[name used_by watchers stars forks contributors issues].freeze
    @table << all_gems.values_at(*fields)
  end

  def sort_and_customise_top
    @all_gems_top.each do |all_gems|
      next unless appropriate_name?(all_gems)

      create_new_position_in_top(all_gems)
      customise_top
    end
  end

  def customize_top_last_elements
    @table.last[5] = @table.last[5].to_s + ' contributors'
    @table.last[6] = @table.last[6].to_s + ' issues'
  end

  def appropriate_name?(all_gems)
    all_gems[:name] =~ /#{@contains_in_name}/
  end
end
