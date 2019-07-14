require 'yaml'
require 'net/http'
require 'uri'
require 'json'
require 'graphql'

def gems_stat
  api_url = 'https://api.github.com/graphql'
  gems_names = YAML::load(open('gems-names.yml'))['gems']
  gems_names.each do |gem|
    search_api_url = 'https://api.github.com/search/repositories?q=' + gem.to_s
    uri1 = URI.parse(search_api_url)
    gems_info = Net::HTTP.get(uri1)
    hh_data = JSON.parse(gems_info)
    owner = hh_data['items'][0]['owner']['login']
    params = 'watchers{totalCount}forks{totalCount}mentionableUsers{totalCount}stargazers{totalCount}issues(states: OPEN){totalCount}'
    parameters =  "{\"query\":\"{repository(owner: \\\"#{owner}\\\", name: \\\"#{gem}\\\"){#{params}}}\"}"
    uri = URI.parse(api_url)
    # request = Net::HTTP::Post.new(uri2.request_uri, initheader = {'Content-Type' =>'application/json'})
    #uri = URI.parse("https://auth.api.rackspacecloud.com")
    # uri = URI.parse("http://httpbin.org/post")
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(uri.path)
    # req.set_form_data('from' => '2005-01-01', 'to' => '2005-03-31')
    request['User-Agent'] = 'Ale23432423'
    request['Authorization'] = 'token f56ec4336d39a04d4547f6a43b2ef0844f2227f7'

    # http = Net::HTTP.new(uri.host, uri.port)
    # http.use_ssl = true
    # http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    # req.set_form_data('query' => @parameters)
    request.body = parameters
    res = https.request(request)

case res
when Net::HTTPSuccess, Net::HTTPRedirection
  # OK
  puts "#{res.body}"
else
  puts res.body
end

    # response = http.request(req)
    # puts "response #{response.body}"

    # gem_data = []
    # gem_data.push(gem, watch, stars, forks, open_issues)
    # i = 0
    # gem_data.each do |item|
    #   if item.to_s.length > @stat_length[i] then @stat_length[i] = item.to_s.length end
    #   i += 1
    # end
    # @gems_data.push(gem_data)
  end
  # p @gems_data
  # p @stat_length
end

def stat_output
  # @gems_data.each do |gem_arr|
  #   # gem_string = ""
  #   # i = 0
  #   # gem_arr.each do |gem_stat|
  #   #   space_col = @stat_length[i] - gem_stat.to_s.length
  #   #   gem_string << "#{gem_stat}" + " " * space_col + " | "
  #   #   i += 1
  #   # end
  #   # p gem_string
  # end
end

gems_stat
