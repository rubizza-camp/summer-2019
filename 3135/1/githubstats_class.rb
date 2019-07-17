require 'open-uri'
require 'nokogiri'

# GithubStats class fetches data from github page by html parsing
class GithubStats
  def self.call(github_uri)
    new(github_uri).call
  end

  def call
    stats.merge(used_by).transform_values { |value| value.text.gsub(/\D/, '').to_i }
  end

  private

  def initialize(uri)
    @uri = uri
  end

  # rubocop:disable Security/Open
  def fetch_html(uri)
    Nokogiri::HTML(open(uri))
  end
  # rubocop:enable Security/Open

  # :reek:FeatureEnvy:
  def stats
    doc = fetch_html(@uri)
    tag = doc.css('.social-count')
    {
      watches: tag[0],
      stars: tag[1],
      forks: tag[2],
      issues: doc.css('.Counter')[0],
      contributors: doc.css("span[class='num text-emphasized']")[3]
    }
  end

  def used_by
    doc = fetch_html(@uri << '/network/dependents')
    { used_by: doc.css("a[class='btn-link selected']") }
  end
end
