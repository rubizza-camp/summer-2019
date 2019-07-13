require 'yaml'
require 'terminal-table'
require_relative 'repo'
require_relative 'file_manager'

class GemManager
  include FileManager

  def initialize(params)
    @params = params.map { |param| param.split('=') }.to_h

    @gem_list = gem_list

    @repos = top_gems
  end

  def show
    puts Terminal::Table.new rows: @repos.map(&:rows)
  end

  private

  def gem_list
    if @params['--name']
      parse_file(@params['--file'])['gems'].select { |gem| gem.include? @params['--name'] }
    else
      parse_file(@params['--file'])['gems']
    end
  end

  def top_gems
    if @params['--top']
      gems.sort_by(&:used_by).reverse[0..@params['--top'].to_i - 1]
    else
      gems
    end
  end

  def gems
    @gem_list.map { |gem| Repo.new gem }
  end
end
