require 'YAML'
require 'Gems'
require 'octokit'
require 'uri'

class TopGems
  def run
    list = gem_list('gems.yml')

    client = client('8ab9b46acee5e6c2eae941db1dd39b5d4767ef24')
    client.user.login
    list.each do |gem|
      puts link_to_gem(gem)
      gem_link = link_to_gem(gem)
      result[gem.to_sym] = info(gem_link)
    end
  end

  def gem_list(file)
    YAML.load_file(file)['gems']
  end

  def client(token)
    Octokit::Client.new(access_token: token)
  end

  def link_to_gem(gem)
    Gems.info(gem)['source_code_uri'].gsub('https://github.com/', '')
  end

  def used_by
    used_by_count = dependents(uri).css('.btn-link')[1].text.delete('^0-9').to_i
  end

  def contributors
    contributors_count = contributors(uri).css('span.num.text-emphasized').children[2].text.to_i
  end

  def info(gem_link)
    repositoy = client.repo gem_link

    {
      name: repositoy[:name],
      used: used_by,
      watchers: repositoy[:subscribers_count],
      stargazers: repositoy[:stargazers_count],
      forks_count: repositoy[:forks_count],
      contributors: contributors,
      issues: repositoy[:open_issues_count]
    }
  end
end

TopGems.new.run
