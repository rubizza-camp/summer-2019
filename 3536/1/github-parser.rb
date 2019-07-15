rubocop:disable all
@token = 'f91c9d872afd22e2f6c92f8e4231f5a37d4baa5c'
@api_url = 'https://api.github.com/graphql'
@yml_file = 'top-gems.yml'

def get_owner(repo)
  uri = URI.parse(@api_url)
  https = Net::HTTP.new(uri.host, uri.port)
  https.use_ssl = true
  request = Net::HTTP::Post.new(uri.path)
  request['User-Agent'] = 'Volovenko'
  request['Authorization'] = "token #{@token}"
  request.body =
    "{\"query\":\"{search(query:\\\"#{repo}\\\",type:REPOSITORY,first:1){edges{ node{ ... on Repository {owner{login}}}}}}\"}"

  response = https.request(request)
  owner = JSON.parse(response.read_body)['data']['search']['edges'][0]['node']['owner']['login']
end

def get_data(owner, gem)
  params = 'watchers{totalCount}forks{totalCount}mentionableUsers{totalCount}' \
           'stargazers{totalCount}issues(states: OPEN){totalCount}'
  parameters = "{\"query\":\"{repository(owner:\\\"#{owner}\\\",name:\\\"#{gem}\\\"){#{params}}}\"}"
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
  end
end
