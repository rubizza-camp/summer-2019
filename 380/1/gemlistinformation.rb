require_relative 'searcher'

# return hash with needed information about gems from list
module GemListInformation
  include Searcher

  def find_information(gem_list)
    client = check_token
    gem_list.map! do |gem|
      gem_info = search_info(gem, client)
      if gem_info
        result_from(gem_info)
      else
        gem_list.delete(gem)
      end
    end
  end

  private

  # :reek:UtilityFunction:, :reek:DuplicateMethodCall
  def result_from(info)
    {
      name: info[:api][:name], stargazers: info[:api][:stargazers_count],
      forks_count: info[:api][:forks_count], issues: info[:api][:open_issues_count],
      subscribers: info[:api][:subscribers_count], contributors: info[:page][:contributors],
      used_by: info[:page][:used_by]
    }
  end
end
