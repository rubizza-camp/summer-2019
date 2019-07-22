# frozen_string_literal: true

require_relative 'table.rb'
require_relative 'parse_gem_stats.rb'
require_relative 'runtable.rb'
require 'yaml'
require 'optparse'

class TopGems
  include Table
  def initialize
    parameters = {}
    @threads = []
    load_parameters(parameters)
    @yml_file = yml_from_file(parameters)
    @gem_list = parameters[:name] ? select_name(parameters) : @yml_file['gems']
    @repos = parameters[:top] ? sort_top(load_gems, parameters) : load_gems
    show
  end

  private

  attr_accessor :threads, :gem_list, :yaml_file, :repos

  def load_parameters(parameters)
    OptionParser.new do |opts|
      opts.on('--name[=OPTIONAL]', String, 'gem name')
      opts.on('--file[=OPTIONAL]', String, 'name file')
      opts.on('--top[=OPTIONAL]', Integer, 'show top')
    end.parse!(into: parameters)
  end

  def show
    table_str = @repos.map do |repo|
      create_string_table(repo)
    end
    print_table(table_str)
  end

  def select_name(parameters)
    @yml_file['gems'].select { |gem| gem.include? parameters[:name] }
  end

  def load_gems
    list = []
    @gem_list.map do |gem|
      @threads << Thread.new do
        list << ParseGemStatsFromGitHub.call(gem)
      end
    end
    wait_for_threads(list)
  end

  def wait_for_threads(list)
    @threads.each(&:join)
    list
  end

  def sort_top(gems, parameters)
    range = [parameters[:top], gems.size].min
    gems.sort_by { |element| element.stats_from_git[:stars] }[-range..-1].reverse
  end

  def yml_from_file(parameters)
    parameters[:file] = 'gems.yml' unless parameters[:file]
    YAML.load_file(File.open(parameters[:file]))
  end
end
