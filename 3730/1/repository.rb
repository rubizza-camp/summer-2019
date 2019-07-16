require 'rest-client'
require 'json'
require 'gems'

class Repository
  def self.a_gem?(name)
    if Gems.info(name).empty?
      puts "No such gem #{name}"
      false
    else
      true
    end
  end

  def self.find_github_url(name)
    url = "https://api.github.com/search/repositories?q=#{name}&per_page=1"
    response = RestClient.get(url)
    JSON.parse(response)['items'][0]['html_url']
  end
end
