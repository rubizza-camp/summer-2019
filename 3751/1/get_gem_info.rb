# frozen_string_literal: true

# Get info from github
class GetGemInfo
  attr_reader :gem

  def initialize(gem)
    @gem = gem
  end

  # :reek:TooManyStatements
  def call
    {
      watchers: social_counters[0],
      stars: social_counters[1],
      forks: social_counters[2],
      contributors: contributors[2],
      users: users[0],
      issues: issues[0],
      closed_issues: issues[2]
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
    main_page.css('.social-count').text.split.map { |arg| arg.tr(',', '').to_i }
  end

  def contributors
    main_page.css('span.text-emphasized').text.split.map { |arg| arg.tr(',', '').to_i }
  end

  def issues
    issues_page.css('.states .btn-link').text.split.map { |arg| arg.tr(',', '').to_i }
  end

  def users
    user_page.css('.btn-link').text.split.map { |arg| arg.tr(',', '').to_i }
  end

  # :reek:InstanceVariableAssumption
  def github_link
    return @github_link if defined?(@github_link)

    gem_hash = Gems.info(gem.name)
    @github_link = gem_hash['source_code_uri'] || gem_hash['homepage_uri']
  end
end
