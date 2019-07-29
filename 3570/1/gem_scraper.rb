# frozen_string_literal: true

require 'json'

class GemScraper
  attr_reader :gem_name

  def initialize(gem_name)
    @gem_name = gem_name
  end

  def scrape
    {
      name: gem_name,
      used_by: used_by,
      contributors: sanitize_counter(gem_page.css('a[href$="contributors"] span')),
      issues: sanitize_counter(gem_page.css('a[href$="issues"] span.Counter'))
    }.merge(watched_stars_forks)
  end

  private

  def github_link
    @github_link ||= begin
      response = Curl.get("https://rubygems.org/api/v1/gems/#{gem_name}.json").body_str
      gem_info = JSON.parse(response)
      format_url(gem_info['source_code_uri'] || gem_info['homepage_uri'])
    end
  end

  def info_block
    @info_block ||= gem_page.css('.pagehead-actions')
  end

  def gem_page
    @gem_page ||= Nokogiri.HTML(Curl.get(github_link).body)
  end

  def format_url(url)
    url.gsub('http:', 'https:')
  end

  def sanitize_counter(counter_element)
    counter_element.text.strip.delete(',').to_i
  end

  def watched_stars_forks
    {
      watched_by: sanitize_counter(info_block.css("a.social-count[href$='watchers']")),
      stars: sanitize_counter(info_block.css("a.social-count[href$='stargazers']")),
      forks: sanitize_counter(info_block.css("a.social-count[href$='members']"))
    }
  end

  def used_by
    github_link.delete_suffix('/')
    link_for_used_by = "#{github_link}/network/dependents"
    used_by_page = Curl.get(link_for_used_by)
    page_body = Nokogiri.HTML(used_by_page.body)
    page_body.css("a[class='btn-link selected']").text.delete('Repositories').strip.delete(',').to_i
  end
end
