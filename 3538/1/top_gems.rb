require 'yaml'
require 'net/http'
require 'uri'
require 'json'
require 'graphql'

@token = 'e9d88495a0a951db1b9b1b273851be0157a8e7de'
@api_url = 'https://api.github.com/graphql'
@yml_file = 'gems-names.yml'

def get_owner(repo)

  uri = URI.parse(@api_url)
  https = Net::HTTP.new(uri.host, uri.port)
  https.use_ssl = true
  request = Net::HTTP::Post.new(uri.path)
  request['User-Agent'] = '3538-1'
  request['Authorization'] = "token #{@token}"
  request.body = "{\"query\":\"{search(query: \\\"#{repo}\\\", type: REPOSITORY, first:1){edges { node { ... on Repository { owner { login }}}}}}\"}"

  response = https.request(request)
  owner = JSON.parse(response.read_body)['data']['search']['edges'][0]['node']['owner']['login']
end

def get_data(owner,gem)

  params = 'watchers{totalCount}forks{totalCount}mentionableUsers{totalCount}stargazers{totalCount}issues(states: OPEN){totalCount}'
  parameters =  "{\"query\":\"{repository(owner: \\\"#{owner}\\\", name: \\\"#{gem}\\\"){#{params}}}\"}"

  uri = URI.parse(@api_url)
  https = Net::HTTP.new(uri.host, uri.port)
  https.use_ssl = true
  request = Net::HTTP::Post.new(uri.path)
  request['User-Agent'] = '3538-1'
  request['Authorization'] = "token #{@token}"
  request.body = parameters
  res = https.request(request)
  result = JSON.parse(res.body)['data']['repository']

  case res
  when Net::HTTPSuccess, Net::HTTPRedirection
    table = {}
    table['watchers'] = result['watchers']['totalCount']
    table['forks'] = result['forks']['totalCount']
    table['contributors'] = result['mentionableUsers']['totalCount']
    table['stars'] = result['stargazers']['totalCount']
    table['issues'] = result['issues']['totalCount']
    return table
  else

  end
end

def print_data(gem,data)
  string = "#{gem} | watched by #{data['watchers']} | #{data['stars']} stars | #{data['forks']} forks | #{data['contributors']} contributors | #{data['issues']} issues |"
  puts "#{string}"
end

def main(file)
  gems_names = YAML::load(open("#{file}"))['gems']
  gems_names.each do |gem|
    owner = get_owner(gem)
    gem_data = get_data(owner,gem)
    print_data(gem,gem_data)
    # puts "#{gem_data}"
  end
end

input_array = ARGV
puts input_array.length
puts input_array.to_s

main(@yml_file)
