require './lib/repo_scrapper'
require './lib/rubygems_links'
require './lib/tg_parse'
require './lib/output_table'
require './lib/backup'
require './lib/option_validation'

class TopGems
  include Backup
  attr_reader :data

  def initialize
    @rg_links = RubyGemsLink.new
    @data = []
    @options = TGParse.parse
    @scraper = RepoScrapper.new
  end

  def parse_all_links
    @rg_links.yaml_links.each do |link|
      @scraper.get_repo_page(link)
      repo_info = @scraper.repo_info
      Backup.backup_create(repo_info[:name], repo_info)
    end
  end

  def gathering_data
    @rg_links.gems_name.each do |name|
      @data << Backup.backup_load(name)
    end
  end

  def data_sort
    @data.sort_by! { |el| el[:stars] }.reverse
  end

  def base_table
    data_sort
  end

  def gem_toplist(top_number)
    data_sort.first(top_number.abs)
  end

  def gems_by_name(name)
    data_sort.select! { |dat| dat[:name].include?(name) }
  end

  def parse_and_gathering_data
    Backup.delete_backup
    parse_all_links
    gathering_data
  end

  def backup
    @rg_links.file_to_parse(@options[:file]) if OptionValidation.check_option(@options) == 'g_file'
    if Backup.backup_check @rg_links
      p 'I found backups!'
      gathering_data
    else
      p 'There is no backups. T_T'
      parse_and_gathering_data
    end
  end

  def run
    backup
    show(@options)
  end

  def table_to_show(options)
    return base_table if %w[base g_file].include?(OptionValidation.check_option(options))
    return gem_toplist(options[:top]) if OptionValidation.check_option(options) == 'toplist'
    return gems_by_name(options[:name]) if OptionValidation.check_option(options) == 'by_name'
  end

  def show(options)
    OutputTable.new.full_table table_to_show(options)
  end
end
