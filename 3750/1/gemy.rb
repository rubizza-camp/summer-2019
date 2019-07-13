require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'open-uri'

# :reek:InstanceVariableAssumption
# :reek:TooManyInstanceVariables
# :reek:Attribute
class Gemy
  def initialize(gem_name)
    @gem_name = gem_name
    @scores = {}
    @overall_score = 0
  end

  attr_accessor :overall_score, :scores
  attr_reader :gem_name
  attr_reader :stats

  def find_stats
    find_link_to_repo
    load_stats
  end

  private

  attr_reader :link_to_repo

  def find_link_to_repo
    agent = Mechanize.new
    page = agent.get("https://rubygems.org/gems/#{@gem_name}")
    @link_to_repo = (page.links.find { |link| link.text == 'Source Code' }).href
  end

  # rubocop:disable Metrics/AbcSize, Naming/MemoizedInstanceVariableName
  def load_stats
    @stats ||= {
      watched:        main_doc.css('.social-count')[0].text.strip,
      stars:          main_doc.css('.social-count')[1].text.strip,
      forks:          main_doc.css('.social-count')[2].text.strip,
      contributors:   main_doc.css('.text-emphasized')[3].text.strip,
      issues:         main_doc.css('.Counter')[0].text.strip,
      used:           used
    }
  end
  # rubocop:enable Metrics/AbcSize, Naming/MemoizedInstanceVariableName

  # rubocop:disable Security/Open
  def main_doc
    @main_doc ||= Nokogiri::HTML(open(@link_to_repo.to_s))
  end

  def doc_for_used_by
    @doc_for_used_by = Nokogiri::HTML(open("#{@link_to_repo}/network/dependents"))
  end
  # rubocop:enable Security/Open

  def used
    return @used if @used

    doc_for_used_by.css('.btn-link')[1].text.strip.each_line do |line|
      @used = line.chomp
      break
    end

    @used
  end
end
