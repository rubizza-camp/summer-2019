class ApiParser
  attr_reader :uri_repo, :parsed_git_uri

  def inicialize
    @uri_repo = uri_repo
    @parsed_git_uri = parsed_git_uri
  end

  def parse(gem)
    url = "https://rubygems.org/api/v1/gems/#{gem}.json"
    response = HTTParty.get(url)
    git_uri = response.parsed_response['source_code_uri']
    make_new_path(git_uri)
  end

  def make_new_path(git_uri)
    @uri_repo = git_uri.split('/')
    added_repo = "#{uri_repo[0]}//api.#{uri_repo[2]}/repos/#{uri_repo[3]}/#{uri_repo[4]}"
    github_response = HTTParty.get(added_repo)
    make_repo_referense(git_uri, github_response)
  end

  def make_repo_referense(git_uri, github_response)
    @parsed_git_uri = git_uri.split('/')
    repos = "#{parsed_git_uri[3]}/#{parsed_git_uri[4]}"
    pick_up_parameters(repos, github_response)
  end

  private

  def pick_up_parameters(repos, github_response)
    {
      repos: repos,
      Watch: github_response.parsed_response['subscribers_count'],
      Star: github_response.parsed_response['watchers_count'],
      Fork: github_response.parsed_response['forks_count']
    }
  end
end
