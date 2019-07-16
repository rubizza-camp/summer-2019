class ApiParser
  def initialize(key)
    @client = Octokit::Client.new(access_token: key)
    @attributes = %i[name forks_count score watchers_count full_name html_url]
    @required_attributes = %i[name forks score stars full_name html_url]
  end

  def parse(urls)
    urls.map { |url| information_from_site(url) }
  end

  def urls_of_sites(gems)
    gems.map { |gem| @client.search_repositories(gem, {}).items.first }
  end

  private

  def information_from_site(gems_github_url)
    hash_of_gems_information = {}

    @attributes.zip(@required_attributes).each do |key, velue|
      (hash_of_gems_information[velue] = gems_github_url[key])
    end
    hash_of_gems_information
  end
end
