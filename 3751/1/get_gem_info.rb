# frozen_string_literal: true

# Get info from github
# :reek:InstanceVariableAssumption
class GetGemInfo
  attr_reader :gem

  def initialize(gem)
    @gem = gem
  end

  def to_integer(text)
    text.gsub(',', '').to_i
  end

  def call
    {
      watchers: to_integer(social_counters[0].text),
      stars: to_integer(social_counters[1].text),
      forks: to_integer(social_counters[2].text),
      contributors: to_integer(contributors[3].text),
      users: to_integer(users[1].text.split[0]),
      issues: to_integer(issues[0].text.split[0]),
      closed_issues: to_integer(issues[1].text.split[0])
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
end
