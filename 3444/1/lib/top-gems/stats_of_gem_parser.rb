require 'nokogiri'
require 'open-uri'
# This module uses like service object for parsing html pages
# and getiing stats values
module TopGems
  class StatsOfGemParser
    def self.call(url)
      new.parse_html_page(url)
    end

    def parse_html_page(url)
      doc = Nokogiri::HTML(URI.open(url))
      doc_used_by = Nokogiri::HTML(URI.open(url + '/network/dependents'))
      social_count = doc.css('.social-count')
      prepare_params(doc, doc_used_by, social_count)
    end

    private

    # rubocop:disable Metrics/AbcSize
    def prepare_params(doc, doc_used_by, social_count)
      {
        watched_by: get_clear_text(social_count[0]),
        stars: get_clear_text(social_count[1]),
        forks: get_clear_text(social_count[2]),
        issues: get_clear_text(doc.css('.Counter')[0]),
        contributors: get_clear_text(doc.css('.num').css('.text-emphasized')[3]),
        used_by: get_clear_text(doc_used_by.css('.btn-link').css('.selected'))
      }
    end
    # rubocop:enable Metrics/AbcSize

    def get_clear_text(nokogiri_object)
      nokogiri_object.text.gsub(/[^0-9]/, '').to_i
    end
  end
end
