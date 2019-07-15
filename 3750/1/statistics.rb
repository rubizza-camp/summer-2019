require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'open-uri'
require_relative 'link'

class Statistics
  def initialize(gem_array)
    @gem_array = gem_array
  end

  # rubocop:disable Metrics/AbcSize
  def load_stats
    @gem_array.each do |gem|
      gem.stats = {
        used:           html_file_for_used(gem.gem_name),
        watched:        html_file(gem.gem_name).css('.social-count')[0].text.strip,
        stars:          html_file(gem.gem_name).css('.social-count')[1].text.strip,
        forks:          html_file(gem.gem_name).css('.social-count')[2].text.strip,
        contributors:   html_file(gem.gem_name).css('.text-emphasized')[3].text.strip,
        issues:         html_file(gem.gem_name).css('.Counter')[0].text.strip
      }
    end
  end
  # rubocop:enable Metrics/AbcSize

  def html_file(gem_name)
    repository = Link.new(gem_name)
    main_doc(repository.link_to_repo)
  end

  def html_file_for_used(gem_name)
    repository = Link.new(gem_name)
    find_used(repository.link_to_repo)
  end

  def main_doc(link_to_repo)
    @main_doc = Nokogiri::HTML(URI.open(link_to_repo.to_s))
  end

  def doc_for_used_by(link_to_repo)
    @doc_for_used_by = Nokogiri::HTML(URI.open("#{link_to_repo}/network/dependents"))
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
