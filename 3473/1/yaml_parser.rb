# frozen_string_literal: true

require './git_finder'
require 'yaml'
require 'ruby-progressbar'

module YAMLParser
  private

  def parse(file, name)
    elements = []
    parse_yml(file, name)
    @loaded.each { |elem| parse_elem(elem, elements) }
    elements
  end

  def parse_elem(gem, elements)
    git = GitFinder.new(gem).git
    if git
      elements << GemInfo.new(git, gem)
    else
      @progress.clear
      puts "Can't find #{gem} repo"
    end
    @progress.increment
  end

  def parse_yml(file, name)
    @loaded = YAML.load_file(file)['gems'].filter { |gem| gem.include? name }
    @progress = ProgressBar.create(total: @loaded.size, title: 'rubygems.org parsing')
  rescue NoMethodError
    raise ArgumentError, "File #{file} isn't valid yml file or doesn't contain 'gems' parameter"
  end
end
