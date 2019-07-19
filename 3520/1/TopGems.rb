# rubocop:disable Style/PreferredHashMethods
require './RepoScrapper.rb'
require './RubyGemsLinks.rb'
require './TGParse.rb'
require './OutputTable.rb'
require './lib/Backup'

class TopGems
  include Backup
  attr_reader :data

  def initialize
    @rg_links = RubyGemsLink.new
    @output_table = OutputTable.new
    @scraper = RepoScrapper.new
    @data = []
  end

  def parse_all_links
    p 'here we go'
    @rg_links.yaml_links.each do |link|
      # p link
      @scraper.get_repo_page(link)
      @info = @scraper.repo_info_parse
      Backup.backup_create(@info[:name], @info)
    end
  end

  def gathering_data
    @rg_links.gems_name.each do |name|
      # p name
      @data << Backup.backup_load(name)
    end
  end

  def data_sort
    @data.map! {|el| el.sort_by { |k,v| k = :stars  }}
  end

  def base_table
    @data.each { |dat| @output_table.add_value(dat) }
  end

  def gem_toplist(top_number)
    data_sort.first(top_number) { |dat| @output_table.add_value(dat) }
    show
  end

  def run
    if Backup.backup_check @rg_links.gems_name.each { |s| s.insert(-1, '.yml') }.sort
      # p 'I found backups!'
      gathering_data
    else
      # p 'There is no backups T_T'
      parse_all_links
      gathering_data
    end
    # show
  end

  def show
    @output_table.show_table
  end

end
# rubocop:enable Style/PreferredHashMethods
