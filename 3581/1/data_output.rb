require 'nokogiri'
require 'open-uri'
require 'rubygems'
require 'terminal-table'
require 'optparse'
require 'yaml'

class DataOutput
  def initialize
    @hash_gems = {}
  end

  def read_yml_file
    top_with_param
    list_gems = YAML.load_file(@add_args['file'])
    list_gems['gems'].each do |name_of_gem|
      @hash_gems[name_of_gem] = Parsing.new.site_search(name_of_gem)
    end
  end

  def summ
    @hash_gems.each do |_, gem_param|
      sum = gem_param['used_by'] + gem_param['watch'] + gem_param['star'] + gem_param['fork'] + gem_param['contrib']
      gem_param['sum'] = sum
    end
  end

  def sort_top
    summ
    return @hash_gems = @hash_gems.sort_by { |_, val| -val['sum'] }[0..@add_args['top'] - 1].to_h if @add_args['top']
    @hash_gems = @hash_gems.sort_by { |_, val| -val['sum'] }.to_h
  end

  def top_with_param
    @add_args = {}
    @add_args['file'] = 'gems.yml'
    OptionParser.new do |arg|
      arg.on('-t', '--top = t', Integer) { |t| @add_args['top'] = t }
      arg.on('-n', '--name = n', String) { |n| @add_args['name'] = n }
      arg.on('-f', '--file = f', String) { |f| @add_args['file'] = f }
    end.parse!
  end

  def find_by_name
    @hash_gems.select! { |name, _| name.include?(@add_args['name']) }
  end

  def fill_table
    Terminal::Table.new do |t|
      @hash_gems.each do |name_of_gem, gems_param|
        t << [name_of_gem, 'used by ' "#{gems_param['used_by']}", 'watched by ' "#{gems_param['watch']}",
              "#{gems_param['star']} " 'stars', "#{gems_param['fork']} " 'forks',
              "#{gems_param['contrib']} " 'contributors', "#{gems_param['issues']} " 'issues']
      end
    end
  end

  def draw_table
    sort_top
    find_by_name if @add_args['name']
    top_with_param
    puts fill_table
  end
end
