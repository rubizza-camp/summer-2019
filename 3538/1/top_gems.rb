require 'yaml'
require 'net/http'
require 'uri'
require 'json'

def gems_stat
  @gems_data = []
  @stat_length = Array.new(5, 0)
  gems_names = YAML::load(open('gems-names.yml'))['gems']
  gems_names.each do |gem|
    search_api_url = 'https://api.github.com/search/repositories?q=' + gem.to_s

    uri1 = URI.parse(search_api_url)
    gems_info1 = Net::HTTP.get(uri1)
    hh_data = JSON.parse(gems_info1)
    api_url = hh_data['items'][0]['url']
    stars = hh_data['items'][0]['stargazers_count']
    forks = hh_data['items'][0]['forks_count']
    open_issues = hh_data['items'][0]['open_issues_count']

    uri2 = URI.parse(api_url)
    gems_info2 = Net::HTTP.get(uri2)
    hh_watch = JSON.parse(gems_info2)
    watch = hh_watch['subscribers_count']

    gem_data = []
    gem_data.push(gem, watch, stars, forks, open_issues)
    i = 0
    gem_data.each do |item|
      if item.to_s.length > @stat_length[i] then @stat_length[i] = item.to_s.length end
      i += 1
    end
    @gems_data.push(gem_data)
  end
  p @gems_data
  p @stat_length
end

def stat_output
  @gems_data.each do |gem_arr|
    gem_string = ""
    i = 0
    gem_arr.each do |gem_stat|
      space_col = @stat_length[i] - gem_stat.to_s.length
      gem_string << "#{gem_stat}" + " | " + " " * space_col
      i += 1
    end
    puts gem_string
  end
end

gems_stat
stat_output
