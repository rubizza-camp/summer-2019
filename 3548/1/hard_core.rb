require 'terminal-table'
require 'octokit'
require 'open-uri'
require 'nokogiri'

class TerminalInformation
  def initialize(all_gems_top, top_size, contains_in_name)
    top_size ||= all_gems_top.size
    @top_size = top_size.to_i
    @contains_in_name = contains_in_name
    @all_gems_top = prepare_top(all_gems_top)
    @table = []
  end

  def print_top
    sort_and_customise_top
    puts Terminal::Table.new rows: @table, style: { border_top: false, border_bottom: false }
  end

  private

  def customize_central_top_elements
    @table.last[3] = @table.last[3].to_s + ' stars'
    @table.last[4] = @table.last[4].to_s + ' forks'
  end

  def prepare_top(all_gems_top)
    all_gems_top.sort_by! { |all_gems| - all_gems[:used_by] }
  end

  def customise_top
    customise_top_first_elements
    customize_central_top_elements
    customize_top_last_elements
  end

  def customise_top_first_elements
    @table.last[1] = 'used by ' + @table.last[1].to_s
    @table.last[2] = 'watched by ' + @table.last[2].to_s
  end

  def create_new_position_in_top(all_gems)
    fields = %i[name used_by watchers stars forks contributors issues].freeze
    @table << all_gems.values_at(*fields)
  end

  def sort_and_customise_top
    @all_gems_top.each do |all_gems|
      next unless appropriate_name?(all_gems)

      create_new_position_in_top(all_gems)
      customise_top
    end
  end

  def customize_top_last_elements
    @table.last[5] = @table.last[5].to_s + ' contributors'
    @table.last[6] = @table.last[6].to_s + ' issues'
  end

  def appropriate_name?(all_gems)
    all_gems[:name] =~ /#{@contains_in_name}/
  end
end

# parse all content
class Parser
  def initialize(life)
    @client = Octokit::Client.new(access_token: life)
  end

  def parse(name)
    all_gems = {}
    top_search = search_api(name)
    all_gems = filling_the_data_from_api(all_gems, top_search)
    all_gems = filling_the_data(all_gems, top_search[:full_name])
    all_gems
  end

  REQUEST_CONTRIBUTORS = 'a span[class=\'num text-emphasized\']'.freeze
  REQUEST_USED_BY = 'a[class=\'btn-link selected\']'.freeze

  private

  def filling_the_data_from_api(all_gems, top_search)
    all_gems[:name] = top_search[:name]
    all_gems[:stars] = top_search[:watchers_count]
    all_gems[:forks] = top_search[:forks]
    all_gems
  end

  def search_in_html(request, page)
    raw_text = page.search(request).text
    match = raw_text.match(/(\d+)((,\d+)?)*/)
    match[0].delete(',').to_i unless match.to_s.empty?
  end

  def search_main(all_gems, page, full_name)
    all_gems[:contributors] = search_in_html(REQUEST_CONTRIBUTORS, page)
    all_gems[:watchers] = search_in_html("li a[href=\"/#{full_name}/watchers\"]", page)
    all_gems[:issues] = search_in_html("span a[href=\"/#{full_name}/issues\"]", page)
    all_gems
  end

  def search_api(name)
    search = @client.search_repositories(name)
    search.items.first
  end

  def filling_the_data(all_gems, full_name)
    github_page = Nokogiri::HTML(open("https://github.com/#{full_name}"))
    github_dep = Nokogiri::HTML(open("https://github.com/#{full_name}/network/dependents"))
    all_gems = search_main(all_gems, github_page, full_name)
    all_gems = search_subjection(all_gems, github_dep)
    all_gems
  end

  def search_subjection(all_gems, page)
    all_gems[:used_by] = search_in_html(REQUEST_USED_BY, page)
    all_gems
  end
end
