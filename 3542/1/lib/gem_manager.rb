require 'yaml'
require 'terminal-table'
require_relative 'repo'
require_relative 'util'

class GemManager
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
    gem_list = Util::Parse::YAML.parse(@params['--file'])['gems']

    filter_by '--name', gem_list do |gem|
      gem.include? @params['--name']
    end
  end

  def top_gems
    sorted_gems = gems.sort_by(&:used_by).reverse

    filter_by '--top', sorted_gems do |gem|
      sorted_gems.index(gem) < @params['--top'].to_i
    end
  end

  def filter_by(flag, obj, &block)
    @params[flag] ? obj.select(&block) : obj
  end

  def gems
    @gem_list.map { |gem| Repo.new gem }
  end
end
