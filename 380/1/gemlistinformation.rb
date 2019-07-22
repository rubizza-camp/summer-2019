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

  # :reek:UtilityFunction:
  # rubocop:disable Metrics/MethodLength
  def result_from(info)
    api_info = info[:api]
    page_info = info[:page]
    {
      name: api_info[:name],
      stargazers: api_info[:stargazers_count],
      forks_count: api_info[:forks_count],
      issues: api_info[:open_issues_count],
      subscribers: api_info[:subscribers_count],
      contributors: page_info[:contributors],
      used_by: page_info[:used_by]
    }
  end
  # rubocop:enable Metrics/MethodLength
end
