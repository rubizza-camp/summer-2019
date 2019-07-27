require './lib/repo_scrapper'
require './lib/rubygems_links'
require './lib/tg_parse'
require './lib/output_table'
require './lib/backup'
require './lib/option_validation'
require './lib/gems_progressbar'

class GemsData
  include Backup
  attr_reader :data

  def initialize
    @rg_links = RubyGemsLink.new
    @data = []
    @options = TGParser.parse
    @scraper = RepoScrapper.new
    run
  end

  def parse_all_links
    GemsProgressbar.create(@rg_links.gems_name.size)
    @rg_links.gems_hash.each do |_gem, link|
      next if parse_repo_by_link(link) == 'next'
    end
  end

  def parse_repo_by_link(link)
    if @scraper.get_repo_page(link) == 'flag'
      puts "#{link} skipped."
      return 'next'
    end
    Backup.backup_create(@scraper.repo_info)
    GemsProgressbar.progress
    puts "#{link} parsed"
  end

  def gathering_data
    @rg_links.gems_name.each do |name|
      @data << Backup.backup_load(name) if Backup.backup_file_check(name)
    end
  end

  def base_table_template
    @data.sort_by! { |el| el[:stars] }.reverse
  end

  def gem_toplist(top_number)
    base_table_template.first(top_number.abs)
  end

  def gems_by_name(name)
    base_table_template.select! { |dat| dat[:name].include?(name) }
  end

  def parse_and_gathering_data
    Backup.delete_backup
    parse_all_links
    gathering_data
  end

  def backup
    @rg_links.file_to_parse(@options[:file]) if OptionValidation.check_option(@options) == 'g_file'
    parse_and_gathering_data
  end

  def run
    backup
    show(@options)
  end

  def table_to_show(options)
    return base_table_template if %w[base g_file].include?(OptionValidation.check_option(options))
    return gem_toplist(options[:top]) if OptionValidation.check_option(options) == 'toplist'
    return gems_by_name(options[:name]) if OptionValidation.check_option(options) == 'by_name'
  end

  def show(options)
    OutputTable.new.full_table(table_to_show(options))
  end
end
