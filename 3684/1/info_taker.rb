require 'open-uri'
require 'nokogiri'

# rubocop:disable Security/Open
class InfoTaker
  attr_reader :adress

  def initialize(adress)
    @adress = adress
    @document = Nokogiri::HTML(open(adress.to_s))
    @documnet_for_used_by = Nokogiri::HTML(open("#{adress}/network/dependents"))
    @info = []
  end

  def take_info
    @info = [gem_name, used_by, contributors, issues, stars, watch, forks]
  end

  def gem_name
    adress.split('/').last
  end

  def used_by
    @documnet_for_used_by.css("a[class='btn-link selected']")[0].text.split(' ').first
  end

  def contributors
    @document.css("span[class='num text-emphasized']")[3].text.split(' ').first
  end

  def issues
    @document.css("span[class='Counter']")[0].text.split(' ').first
  end

  def stars
    @document.css("a[class='social-count js-social-count']")[0].text.split(' ').first
  end

  def watch
    @document.css("a[class='social-count']")[0].text.split(' ').first
  end

  def forks
    @document.css("a[class='social-count']")[1].text.split(' ').first
  end
end
# rubocop:enable Security/Open
