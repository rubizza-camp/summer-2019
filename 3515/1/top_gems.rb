require 'yaml'
require 'gems'
require 'mechanize'
require 'httparty'
require 'terminal-table'
require 'pry'

# It looks terrible, doesn't it?
# Load gem file, find gem repo url and check the end of the url for '/'
class FindGemRepoUrl
  attr_reader :hash
  attr_reader :gems_arr

  def load_gem_file(gems_file = 'gems.yml')
    yaml_data = YAML.load_file(gems_file)
    yaml_data.values[0]
  end

  def find_url(gems_arr)
    @hash = {}
    gems_arr.each do |gem_name|
      gems_info = Gems.info gem_name
      gem_rep_url = gems_info['source_code_uri']
      if gem_rep_url.nil? || !gem_rep_url.include?('//github.com/') ||
         HTTParty.get(gem_rep_url).code == 404
        gem_rep_url = gems_info['homepage_uri']
        next if gem_rep_url.nil? || !gem_rep_url.include?('//github.com/') ||
                HTTParty.get(gem_rep_url).code == 404
      end
      @hash.store(gem_name, gem_rep_url)
    end
  end

  def check_url_for_slash
    @hash.each do |key, value|
      if value[-1] == '/'
        next
      else
        value += '/'
        @hash[key] = value
      end
    end
    @hash
  end
end
# Parse data from gem repo
class DataParser
  attr_reader :rows

  def parser(arr)
    @rows = []
    arr.each do |gem_name, gem_url|
      agent = Mechanize.new
      html = agent.get(gem_url)
      watched_by = html.css('ul.pagehead-actions a')[1].text.delete('^0-9')
      stars = html.css('ul.pagehead-actions a')[3].text.delete('^0-9')
      forks = html.css('ul.pagehead-actions a')[5].text.delete('^0-9')
      issues = html.css('nav.hx_reponav span')[4].text
      html = agent.get(gem_url + 'contributors_size')
      contributors = html.css('span.text-emphasized').text.delete('^0-9')
      html = agent.get(gem_url + 'network/dependents')
      used_by = html.css('div.table-list-header-toggle a')[0].text.delete('^0-9')
      gem_rate = if issues.to_i.zero?
                   ((watched_by.to_i + stars.to_i + forks.to_i +
                     contributors.to_i + used_by.to_i) / 0.5).to_i
                 else
                   (watched_by.to_i + stars.to_i + forks.to_i +
                    contributors.to_i + used_by.to_i) / issues.to_i
                 end
      @rows << [gem_name, used_by, watched_by, stars, forks, contributors,
                issues, gem_rate]
    end
    @rows.sort! { |a, b| a[7] <=> b[7] }.reverse!
  end
end
# Build terminal table
class TerminalTable
  def terminal_table(row)
    puts Terminal::Table.new headings: %w[gem_name used_by watched_by stars
                                          forks contributors issues gem_rate],
                             rows: row
  end
end

a = FindGemRepoUrl.new
a.find_url(a.load_gem_file)
a.check_url_for_slash
b = DataParser.new
b.parser(a.hash)
c = TerminalTable.new
c.terminal_table(b.rows)
