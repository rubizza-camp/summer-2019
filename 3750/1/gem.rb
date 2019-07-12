require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'open-uri'
require 'pry'

class Gemy

  def initialize(name)
    @name = name
  end

  def get_links
    agent = agent = Mechanize.new
  end

  def get_stats
    @main_doc = Nokogiri::HTML(open("https://github.com/#{@name}/#{@name}"))
    @doc_for_used_by = Nokogiri::HTML(open("https://github.com/#{@name}/#{@name}/network/dependents"))

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

  def show_stats
    puts "used by #{@used} repositories"
    puts 'stars - ' + @stars.to_s
    puts 'times watched - ' + @watched.to_s
    puts 'number of forks - ' + @forks.to_s
    puts 'contributors - ' + @contributors.to_s
    puts 'number of issues - ' + @issues.to_s
  end
end



# [11] pry(main)> @doc.css('div.text-center .link-gray').first.text
# binding.pry
#

gemy = Gemy.new('rails')
gemy.get_stats { }


