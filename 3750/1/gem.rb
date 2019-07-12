require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'open-uri'
require 'pry'

class Gemy

  def show_stats
    get_links
    get_stats
    puts '--------------------------------------------------------------------------'
    puts "#{@name} |"
    puts '----------------'
    puts "used by #{@used} repositories"
    puts 'stars - ' + @stars.to_s
    puts 'times watched - ' + @watched.to_s
    puts 'number of forks - ' + @forks.to_s
    puts 'contributors - ' + @contributors.to_s
    puts 'number of issues - ' + @issues.to_s
  end

  private

  def initialize(name)
    @name = name
  end

  def get_links
    agent = Mechanize.new
    page = agent.get("https://rubygems.org/gems/#{@name}")
    @link = (page.links.find { |l| l.text == 'Source Code' }).href
  end

  def get_stats
    @main_doc = Nokogiri::HTML(open(@link.to_s))
    @doc_for_used_by = Nokogiri::HTML(open("#{@link}/network/dependents"))

    @doc_for_used_by.css('.btn-link')[1].text.strip.each_line do |line|
      @used = line.chomp
      break
    end
    @watched = @main_doc.css('.social-count')[0].text.strip
    @stars = @main_doc.css('.social-count')[1].text.strip
    @forks = @main_doc.css('.social-count')[2].text.strip
    @contributors = @main_doc.css('.text-emphasized')[3].text.strip
    @issues = @main_doc.css('.Counter')[0].text.strip
  end
end



# [11] pry(main)> @doc.css('div.text-center .link-gray').first.text
# binding.pry


