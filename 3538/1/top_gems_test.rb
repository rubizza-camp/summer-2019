require 'yaml'
require 'net/http'
require 'uri'
require 'json'

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
  return owner
end

def get_data(owner,gem)

  params = 'watchers{totalCount}forks{totalCount}mentionableUsers{totalCount}stargazers{totalCount}issues(states: OPEN){totalCount}releases{totalCount}'
  parameters =  "{\"query\":\"{repository(owner: \\\"#{owner}\\\", name: \\\"#{gem}\\\"){#{params}}}\"}"

  uri = URI.parse(@api_url)
  https = Net::HTTP.new(uri.host, uri.port)
  https.use_ssl = true
  request = Net::HTTP::Post.new(uri.path)
  request['User-Agent'] = '3538-1'
  request['Authorization'] = "token #{@token}"
  request['Accept'] = 'application/vnd.github.hawkgirl-preview+json'
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
    table['usedby'] = result['releases']['totalCount']
    return table
  else

  end
end

def print_data(gem,data)
  string = "#{gem}\s\s\s\s\t| used by #{data['usedby']}\t| watched by #{data['watchers']}\s\t| #{data['stars']} stars\t| #{data['forks']} forks\t| #{data['contributors']} contributors\t| #{data['issues']} issues\t|"
  puts "#{string}"
end

def main
  gems_names = YAML::load(open("#{@yml_file}"))['gems']
  gems_names.each do |gem|
    owner = get_owner(gem)
    gem_data = get_data(owner,gem)
    print_data(gem,gem_data)
  end
end

def pars_param
  input_array = ARGV
  if input_array.length > 0
    input_array.each do |par|
      if par.include?'--file'
        @yml_file = par.delete_prefix('--file=')
      elsif par.include?'--top'

      elsif par.include?'--name'

      else
        #exception
      end
    end
  end
end

pars_param
main
