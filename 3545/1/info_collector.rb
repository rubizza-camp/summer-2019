require 'nokogiri'
require 'open-uri'
require 'json'
require './points_calculator'

class InfoCollector
  def initialize(github_link)
    @gem_name = github_link.split('/').last.capitalize
    @doc = Nokogiri::HTML(URI.open(github_link))
    @doc_for_used_by = Nokogiri::HTML(URI.open(github_link + '/network/dependents'))
    @result_array = []
  end

  def stars
    @doc.css('.social-count')[1]
  end

  def watched_by
    @doc.css('.social-count')[0]
  end

  def forks
    @doc.css('.social-count')[2]
  end

  def contributors
    @doc.css("span[class ='num text-emphasized']")[3]
  end

  def issues
    @doc.css('.Counter')
  end

  def used_by
    @doc_for_used_by.css('a.btn-link.selected')
  end

  def pack_all
    @result_array = [stars, watched_by, forks, contributors, issues, used_by]
    @result_array.map! { |param| param.text.strip.gsub(/[^\d^\.]/, '').to_i }.insert(0, @gem_name)
  end

  def result
    pack_all
    @result_array.insert(1, PointsCalculator.new(@result_array).calculate_all)
  end
end
