require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'open-uri'

class Statistics
  def initialize(gem_array)
    @gem_array = gem_array
  end

  # rubocop:disable Metrics/AbcSize
  def load_stats
    @gem_array.each do |gem|
      gem.stats = {
        watched:        html_file(gem.gem_name).css('.social-count')[0].text.strip,
        stars:          html_file(gem.gem_name).css('.social-count')[1].text.strip,
        forks:          html_file(gem.gem_name).css('.social-count')[2].text.strip,
        contributors:   html_file(gem.gem_name).css('.text-emphasized')[3].text.strip,
        issues:         html_file(gem.gem_name).css('.Counter')[0].text.strip,
        used:           html_file(gem.gem_name, 'used')
      }
    end
  end
  # rubocop:enable Metrics/AbcSize

  def html_file(gem_name, flag = '')
    return find_used(link_to_repo(gem_name)) if flag == 'used'
    main_doc(link_to_repo(gem_name))
  end

  def link_to_repo(gem_name)
    agent = Mechanize.new
    page = agent.get("https://rubygems.org/gems/#{gem_name}")
    (page.links.find { |link| link.text == 'Source Code' }).href
  end

  def main_doc(link_to_repo)
    @main_doc = Nokogiri::HTML(open(link_to_repo.to_s))
  end

  def doc_for_used_by(link_to_repo)
    @doc_for_used_by = Nokogiri::HTML(open("#{link_to_repo}/network/dependents"))
  end

  def find_used(link_to_repo)
    used = ''
    doc_for_used_by(link_to_repo).css('.btn-link')[1].text.strip.each_line do |line|
      used = line.chomp
      break
    end
    used
  end
end