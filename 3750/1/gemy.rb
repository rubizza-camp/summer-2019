require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'open-uri'
<<<<<<< HEAD
require_relative 'statistics'

# :reek:Attribute
# im working on this right now
class Gemy
  def initialize(gem_name)
    @gem_name = gem_name
    @stats = {}
    @scores = {}
    @overall_score = 0
  end

  attr_accessor :overall_score, :scores
  attr_reader :gem_name
  attr_accessor :stats
end
=======
require 'pry'

class Gemy
  def initialize(gem_name)
    @gem_name = gem_name
  end

  attr_reader :gem_name
  attr_reader :stats

  def self.get_stats(gem_name)
    gemy = new(gem_name)
    gemy.get_stats
    gemy.stats
  end

  def get_stats
    get_link_to_repo
    load_stats
  end

  private

  attr_reader :link_to_repo

  def get_link_to_repo
    agent = Mechanize.new
    page = agent.get("https://rubygems.org/gems/#{@gem_name}")
    @link_to_repo = (page.links.find { |l| l.text == 'Source Code' }).href
  end

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

  def main_doc
    @main_doc ||= Nokogiri::HTML(open(@link_to_repo.to_s))
  end

  def doc_for_used_by
    @doc_for_used_by = Nokogiri::HTML(open("#{@link_to_repo}/network/dependents"))
  end

  def used
    return @used if @used

    doc_for_used_by.css('.btn-link')[1].text.strip.each_line do |line|
      @used = line.chomp
      break
    end

    @used
  end

end



# [11] pry(main)> @doc.css('div.text-center .link-gray').first.text
# binding.pry


>>>>>>> add hash for stats storing
