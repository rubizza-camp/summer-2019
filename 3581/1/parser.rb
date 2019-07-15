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
    source_code =  page.css('a#code')
    home_page = page.css('a#home').attr('href').value
    check_page(source_code, home_page, name_of_gem)
  end

  def check_page (source_code, home_page, name_of_gem)
    if !source_code.empty?
      source_code = source_code.attr('href').value 
      url = source_code
    elsif home_page.include?('github')
      url = home_page
    else
      url = ''
    end 
    get_all_param(url, name_of_gem) if !url.empty?
  end

  def get_all_param(url, name_of_gem)
    html = open(url)
    doc = Nokogiri::HTML(html)
    used_by = get_used_by(url)
    first_part = get_watch_star_fork(doc)
    issues = doc.css('.hx_reponav span a .Counter')[0].text.strip.to_i
    contrib = doc.css('.numbers-summary li')[3].css('a span').text.strip.to_i
    fill_hash(first_part, contrib, issues, used_by)
  end

  # def converse_to_i(str)
  #   str = str.delete(',').to_i
  # end

  def get_watch_star_fork(doc)
    first_part = []
    doc.css('.pagehead-actions li').each do |li| 
      if !li.css('a').empty?
        data=li.css('a')[1]
        first_part << data
      end
    end
  end
    
  def get_used_by(url) 
    url << "/network/dependents"
    html = open(url)
    doc = Nokogiri::HTML(html)
    used_by = doc.css('a.btn-link')[0].text.strip
    used_by = used_by.delete "\n Repositories"
    used_by = used_by.sub!(',', '_').to_i
  end

  def fill_hash(first_part, contrib, issues, used_by)
    gems_param = {}
    gems_param['used_by'] = used_by
    gems_param['watch'] = first_part[0].text.strip.delete('Watch').to_i
    gems_param['star'] = first_part[1].text.strip.delete('Star').to_i
    gems_param['fork'] = first_part[2].text.strip.delete('Fork').to_i
    gems_param['issues'] = issues
    gems_param['contrib'] = contrib
    gems_param
  end
end
