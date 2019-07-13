# frozen_string_literal: true

require 'watir'
require 'webdrivers'

module GitParser
  private

  WAIT_LOAD = 2

  def parse(link)
    @params = {}
    browse link
    @params.each { |key, value| @params[key] = value.gsub(/\s*,*/, '').to_i }
  end

  def browse(link)
    browser = Watir::Browser.new(:chrome, headless: true)
    read browser, link
    browser.close
  end

  def read(browser, link)
    browser.goto("#{link}/network/dependents")
    read_used_by browser
    browser.goto(link)
    read_watched_stars_forks_contributors_issues browser
  end

  def wait(browser)
    browser.wait_until(timeout: WAIT_LOAD) do
      browser.elements(css: '.social-count').size == 3 &&
        browser.elements(css: 'span.text-emphasized').size == 4
    end
  end

  def read_used_by(doc)
    @params[:used] = doc.html.to_s.match(/(\d*,?\d*,?\d+)\s*(Repo)/).captures.first.strip
  end

  def read_watched_stars_forks_contributors_issues(doc)
    wait(doc)
    read_watched_stars_forks doc
    read_contributors_issues doc
  end

  def read_watched_stars_forks(doc)
    @params[:watch], @params[:star], @params[:fork] =
      doc.elements(css: '.social-count').map { |item| item.text.strip }
  end

  def read_contributors_issues(doc)
    @params[:contributor] = doc.elements(css: 'span.text-emphasized').last.text.strip
    @params[:issue] = doc.elements(css: 'span.Counter').first.text.strip
  end
end
