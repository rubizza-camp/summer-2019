# frozen_string_literal: true

require 'nokogiri'
require_relative 'github_api'

class GemStatistic
  attr_reader :gem_name
  def initialize(gem_name)
    @gem_name = gem_name
  end

  def create_stat
    {
      gem_name: gem_name,
      used_by: find_used_by,
      watched_by: find_watched_by,
      stars: find_stars,
      forks: find_forks,
      contributors: find_contributors,
      open_issues: find_issues
    }
  end

  private

  def find_repo
    @find_repo ||= GithubAPI.new(gem_name).find_repo
  end

  def downgload_html
    @downgload_html ||= Nokogiri.HTML(URI.open(find_repo))
  end

  def downgload_used_html
    @downgload_used_html ||= Nokogiri.HTML(URI.open("#{find_repo}/network/dependents"))
  end

  def find_used_by
    downgload_used_html.css('.btn-link').css('.selected').text.tr('^0-9', '').to_i
  end

  def find_watched_by
    downgload_html.css("a[class='social-count']")[0].text.tr('^0-9', '').to_i
  end

  def find_stars
    downgload_html.css("a[class='social-count js-social-count']").text.tr('^0-9', '').to_i
  end

  def find_forks
    downgload_html.css("a[class='social-count']")[1].text.tr('^0-9', '').to_i
  end

  def find_contributors
    downgload_html.css("span[class='num text-emphasized']")[-1].text.tr('^0-9', '').to_i
  end

  def find_issues
    downgload_html.css("span[class='Counter']")[0].text.tr('^0-9', '').to_i
  end
end
