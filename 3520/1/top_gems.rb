# rubocop:disable Style/PreferredHashMethods
require './repo_scrapper.rb'
require './rubygems_links'
require './tg_parse.rb'
require './output_table.rb'
require 'yaml'

class TopGems
  def initialize
    @rg_links = RubyGemsLink.new
    @output_table = OutPutTable.new
    @links = @rg_links.yaml_links
    @scraper = RepoScrapper.new
  end

  def backup_check
    if backup_dir_check
      Dir["./yaml/tmp/*.yml"].each { |s| s.slice!('./yaml/tmp/') } == @rg_links.gems_name.each { |s| s.insert(-1, '.yml') }
    end
  end

  def backup_dir_check
      Dir.exist?('yaml/tmp')
  end

  def backup_path_regexp(gem_name)
    "./yaml/tmp/#{gem_name}.yml"
  end

  def backup_create(gem_name, gem_info)
    if backup_dir_check
      File.write(backup_path_regexp(gem_name), gem_info.to_yaml) # unless File.exist?(backup_path_regexp(gem_info))
    else
      Dir.mkdir('yaml/tmp') unless Dir.exist?('yaml/tmp')
      p 'dir created'
      backup_create(gem_name, gem_info)
    end
  end

  def backup_load(filename)
    if backup_dir_check && File.exist?(backup_path_regexp(filename))
      YAML.load File.read backup_path_regexp(filename)
    else
      raise 'smth wrong with backup'
    end
  end

  def parse_all_links
    p 'here we go'
    @links.each do |link|
      p link
      @scraper.get_repo_page(link)
      @info = @scraper.repo_info_parse
      backup_create(@info[:name], @info)
    end
  end

  def run
    parse_all_links unless backup_check
    @rg_links.gems_name.each do |name|
      p name
      @output_table.add_value(backup_load(name))
    end
    puts @output_table.show_table
  end
end

top = TopGems.new

top.run


# rubocop:enable Style/PreferredHashMethods
