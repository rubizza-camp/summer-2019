# frozen_string_literal: true

# Get info from github
# :reek:InstanceVariableAssumption
class GetGemInfo
  attr_reader :gem

  def initialize(gem)
    @gem = gem
  end

  def call # rubocop:disable Metrics/AbcSize
    open_issues = to_integer(issues[0].text.split[0])
    closed_issues = to_integer(issues[1].text.split[0])

    gem.options = {
      watchers: to_integer(social_counters[0].text) * 2,
      stars: to_integer(social_counters[1].text) * 3,
      forks: to_integer(social_counters[2].text),
      contributors: to_integer(contributors[3].text) * 10,
      users: to_integer(users[1].text.split[0]) / 100,
      issues: (closed_issues / 4) - (open_issues * 2)
    }
  end

  def main_page
    @main_page ||= Nokogiri::HTML(Kernel.open(github_link))
  end

  def user_page
    Nokogiri::HTML(Kernel.open(github_link + '/network/dependents'))
  end

  def issues_page
    Nokogiri::HTML(Kernel.open(github_link + '/issues'))
  end

  def social_counters
    main_page.css('.social-count')
  end

  def contributors
    main_page.css('span.text-emphasized')
  end

  def issues
    issues_page.css('.states .btn-link')
  end

  def users
    user_page.css('.btn-link')
  end

  def github_link
    return @github_link if defined?(@github_link)

    gem_hash = Gems.info(gem.name)
    @github_link = gem_hash['source_code_uri'] || gem_hash['homepage_uri']
  end

  # :reek:UtilityFunction
  def to_integer(text)
    text.delete(',', '').to_i
  end
end
