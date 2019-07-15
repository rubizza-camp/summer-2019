require 'nokogiri'
require 'open-uri'
require 'rubygems'
require 'terminal-table'
require 'optparse'
require 'yaml'
require_relative 'data_output.rb'

class Parsing
  def site_search(name_of_gem)
    page = Nokogiri::HTML(URI.open("https://rubygems.org/gems/#{name_of_gem}"))
    source_code = page.css('a#code')
    home_page = page.css('a#home').attr('href').value
    check_page(source_code, home_page)
  end

  def check_page(source_code, home_page)
    if !source_code.empty?
      source_code = source_code.attr('href').value
      url = source_code
    elsif home_page.include?('github')
      url = home_page
    else
      url = ''
    end
    get_all_param(url) unless url.empty?
  end

  def get_all_param(url)
    html = URI.open(url)
    doc = Nokogiri::HTML(html)
    parse_css(doc, url)
  end

  def parse_css(doc, url)
    used_by = get_used_by(url)
    first_part = get_watch_star_fork(doc)
    issues = doc.css('.hx_reponav span a .Counter')[0].text.strip.to_i
    contrib = doc.css('.numbers-summary li')[3].css('a span')
    fill_hash(first_part, contrib, issues, used_by)
  end

  def get_watch_star_fork(doc)
    first_part = []
    doc.css('.pagehead-actions li').each do |li|
      unless li.css('a').empty?
        data = li.css('a')[1]
        first_part << data
      end
    end
  end

  def get_used_by(url)
    url << '/network/dependents'
    html = URI.open(url)
    doc = Nokogiri::HTML(html)
    used_by = doc.css('a.btn-link')[0].text.strip.delete("\n Repositories")
    used_by.sub!(',', '_').to_i
  end

  def delete_words(gems_param)
    gems_param['watch'] = gems_param['watch'].delete('Watch').to_i
    gems_param['star'] = gems_param['star'].delete('Star').to_i
    gems_param['fork'] = gems_param['fork'].delete('Fork').to_i
    puts gems_param
    gems_param
  end

  def fill_first_part(gems_param, first_part)
    gems_param['watch'] = first_part[0].text.strip
    gems_param['star'] = first_part[1].text.strip
    gems_param['fork'] = first_part[2].text.strip
    delete_words(gems_param)
  end

  def fill_hash(first_part, contrib, issues, used_by)
    gems_param = {}
    gems_param['used_by'] = used_by
    fill_first_part(gems_param, first_part)
    gems_param['issues'] = issues
    gems_param['contrib'] = contrib.text.strip.to_i
    gems_param
  end
end
