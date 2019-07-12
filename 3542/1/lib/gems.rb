require 'yaml'
require 'terminal-table'
require_relative 'repo'

class Gems
  def initialize(params)
    @params = params.map { |param| param.split('=') }.to_h

    @gem_list = @params['--name'] ? filter_by_name(gem_list) : gem_list['gems']

    @repos = @params['--top'] ? top(gems) : gems
  end

  #:reek:FeatureEnvy
  # rubocop:disable Style/UnneededInterpolation
  # rubocop:disable Metrics/MethodLength
  def show
    table_rows = @repos.map do |repo|
      [
        "#{repo.name}",
        "used by #{repo.used_by}",
        "watched by #{repo.watched_by}",
        "#{repo.stars} stars",
        "#{repo.forks} forks",
        "#{repo.contributors} contributors",
        "#{repo.issues} issues"
      ]
    end
    table = Terminal::Table.new rows: table_rows
    puts table
  end
  # rubocop:enable Style/UnneededInterpolation
  # rubocop:enable Metrics/MethodLength

  private

  def filter_by_name(gem_list)
    gem_list['gems'].select { |gem| gem.include? @params['--name'] }
  end

  def gems
    @gem_list.map { |gem| Repo.new gem }
  end

  def top(gems)
    gems.sort_by(&:used_by)[-@params['--top'].to_i..-1].reverse
  end

  def gem_list
    YAML.safe_load file @params['--file']
  end

  def file(path)
    File.open File.expand_path(path)
  end
end