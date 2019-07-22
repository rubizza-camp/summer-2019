class ApiParser
  def initialize(key)
    @client = Octokit::Client.new(access_token: key)
    @gem_information = {}
  end

  def call(name_of_gem)
    response_from_api = all_data_of_site_from_github(name_of_gem)
    assign_the_parameters(response_from_api)
    @gem_information
  end

  private

  def all_data_of_site_from_github(name_of_gem)
    @client.search_repositories(name_of_gem).items.first
  end

  def assign_the_parameters(response_from_api)
    @gem_information[:name]      = response_from_api[:name]
    @gem_information[:score]     = response_from_api[:score]
    @gem_information[:forks]     = response_from_api[:forks_count]
    @gem_information[:stars]     = response_from_api[:watchers_count]
    @gem_information[:full_name] = response_from_api[:full_name]
  end
end
