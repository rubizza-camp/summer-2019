require 'nokogiri'
require 'httparty'
require 'open-uri'

#:reek:TooManyInstanceVariables
class GitGet
  URI = 'https://api.github.com/search/repositories?q='.freeze
  SRC = '&sort=stars&order=desc@per_page=1'.freeze
  attr_reader :name, :used_by, :watched_by, :stars, :forks, :contributors, :issues

  def initialize(gem_name)
    @api_response = HTTParty.get("#{URI}#{gem_name}#{SRC}")
    @repo = repository
    @html = use_nokogiri
    @name = @repo[:name]
    @stars = @repo[:watchers_count]
    @forks = @repo[:forks_count]
    @issues = @repo[:open_issues_count]
    @contributors = contributors_count
    @watched_by = watched_by_count
    @used_by = used_by_count
  end

  private

  def use_nokogiri
    Nokogiri::HTML(::Kernel.open(@repo[:html_url]))
  end

  def repository
    symbolize @api_response.to_hash['items'].first
  end

  def symbolize(hash)
    hash.transform_keys do |key|
      key.to_sym if key.method(:to_sym)
    end
  end

  def contributors_count
    contributors = @html.css("a span[class='num text-emphasized']").last.text
    to_num(contributors)
  end

  def watched_by_count
    stars = @html.xpath('/html/body/div[4]/div/main/div[1]/div/ul/li').select do |el|
      el.text.include? 'Watch'
    end.first.text
    to_num(stars)
  end

  def used_by_count
    html = Nokogiri::HTML(::Kernel.open("#{@repo[:html_url]}/network/dependents"))
    used_by = html.css('a.btn-link:nth-child(1)').text
    to_num(used_by)
  end

  def to_num(num_string)
    num_string.gsub(/[^0-9]/, '').to_i
  end
end
