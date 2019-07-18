# frozen_string_literal: true

require_relative 'gem_scraper'

class Parser
  def initialize(gems_list)
    @gems_list = gems_list
  end

  def parse
    @gems_list.map { |gem_name| GemScraper.new(gem_name).scrape }
  end
end
