require 'httparty'
require 'nokogiri'
require 'open-uri'

#:reek:TooManyInstanceVariables
#:reek:InstanceVariableAssumption
class Repo
  URI = 'https://api.github.com/search/repositories'.freeze

  attr_reader :name, :used_by, :watched_by_amount, :stars, :forks, :contributors_amount, :issues

  def initialize(gem_name)
    repository gem_name
    @html = parse_html @repo['html_url']
    @name = @repo['name']
    @stars = @repo['watchers_count']
    @forks = @repo['forks_count']
    @issues = @repo['open_issues_count']
    @contributors_amount = contributors_count
    @watched_by_amount = watched_by_count
    @used_by = used_by_count
  end

  def rows
    [
      @name.to_s,
      "used by #{@used_by}",
      "watched by #{@watched_by_amount}",
      "#{@stars} stars",
      "#{@forks} forks",
      "#{@contributors_amount} contributors",
      "#{@issues} issues"
    ]
  end

  private

  def repository(gem_name)
    api_response = HTTParty.get(URI, query: { q: gem_name })

    @repo = api_response.to_hash['items'].first
  end

  def contributors_count
    contributors = @html.css("a span[class='num text-emphasized']").last.text
    parse_int(contributors)
  end

  def watched_by_count
    stars = @html.xpath('/html/body/div[4]/div/main/div[1]/div/ul/li').select do |el|
      el.text.include? 'Watch'
    end.first.text
    parse_int(stars)
  end

  def used_by_count
    html = parse_html "#{@repo['html_url']}/network/dependents"
    used_by = html.css('a.btn-link:nth-child(1)').text
    parse_int(used_by)
  end

  def parse_int(num_string)
    num_string.gsub(/[^0-9]/, '').to_i
  end

  # rubocop:disable Security/Open
  def parse_html(url)
    Nokogiri::HTML(open(url))
  end
  # rubocop:enable Security/Open
end
