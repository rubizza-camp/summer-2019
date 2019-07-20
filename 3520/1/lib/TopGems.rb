# rubocop:disable Style/PreferredHashMethods
require './lib/RepoScrapper.rb'
require './lib/RubyGemsLinks.rb'
require './lib/TGParse.rb'
require './lib/OutputTable.rb'
require './lib/Backup'

class TopGems
  include Backup
  attr_reader :data

  def initialize
    @rg_links = RubyGemsLink.new
    @scraper = RepoScrapper.new
    @data = []
  end

  def parse_all_links
    @rg_links.yaml_links.each do |link|
      @scraper.get_repo_page(link)
      @info = @scraper.repo_info_parse
      Backup.backup_create(@info[:name], @info)
    end
  end

  def gathering_data
    @rg_links.gems_name.each do |name|
      @data << Backup.backup_load(name)
    end
  end

  def data_sort
    @data.sort_by! {|el| el[:stars] }.reverse
  end

  def create_table(data)
    @output_table = OutputTable.new
    data.each { |dat| @output_table.add_value(dat) }
    puts @output_table.show_table
  end

  def base_table
    data_sort
  end

  def gem_toplist(top_number)
    data_sort.first(top_number)
  end

  def gems_by_name(name)
    data_sort.select! {|dat| dat[:name].include?(name)}
  end

  def run(options)
    @rg_links.file = options[:file] if options.keys.include?(:file)
    if Backup.backup_check @rg_links.gems_name.each { |s| s.insert(-1, '.yml') }.sort
      p 'I found backups!'
      gathering_data
    else
      p 'There is no backups T_T'
      Backup.delete_backup
      parse_all_links
      gathering_data
    end
    show(options)
  end

  def show(options)
    Backup.delete_backup if options[:delete]
    create_table base_table if options.empty? || options.keys.include?(:file)
    create_table gem_toplist(options[:top]) if options.keys.include?(:top) && options[:top] > 0
    create_table gems_by_name(options[:name]) if options.keys.include?(:name)
  end
end
# rubocop:enable Style/PreferredHashMethods
