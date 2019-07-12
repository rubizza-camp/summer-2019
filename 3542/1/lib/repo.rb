require 'httparty'
require 'nokogiri'
require 'open-uri'

#:reek:TooManyInstanceVariables
class Repo
  URI = 'https://api.github.com/search/repositories'.freeze

  attr_reader :name, :used_by, :watched_by, :stars, :forks, :contributors, :issues

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Security/Open
  def initialize(gem_name)
    @api_response = HTTParty.get(URI, query: { q: gem_name })
    @repo = repository
    @html = Nokogiri::HTML(open(@repo[:html_url]))
    @name = @repo[:name]
    @stars = @repo[:watchers_count]
    @forks = @repo[:forks_count]
    @issues = @repo[:open_issues_count]
    @contributors = contributors_count
    @watched_by = watched_by_count
    @used_by = used_by_count
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Security/Open

  private

  def repository
    symbolize @api_response.to_hash['items'].first
  end

  # rubocop:disable Style/RescueModifier
  def symbolize(hash)
    hash.transform_keys { |key| key.to_sym rescue key }
  end
  # rubocop:enable Style/RescueModifier

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

  # rubocop:disable Security/Open, Lint/UnneededCopDisableDirective
  def used_by_count
    html = Nokogiri::HTML(open("#{@repo[:html_url]}/network/dependents"))
    used_by = html.css('a.btn-link:nth-child(1)').text
    to_num(used_by)
  end
  # rubocop:enable Security/Open, Lint/UnneededCopDisableDirective

  def to_num(num_string)
    num_string.gsub(/[^0-9]/, '').to_i
  end
end