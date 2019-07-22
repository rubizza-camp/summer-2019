require 'nokogiri'
require 'octokit'

# Include methods for searching information about gems
module Searcher
  def check_token
    puts 'Enter Github API Access Token'
    token = gets.chomp.to_s
    Octokit::Client.new(access_token: token)
  rescue Octokit::Unauthorized
    puts 'Wrong Access Token, '
    check_token(token)
  end

  def search_info(gem_hash, client)
    repo_id = parse_uri_of(gem_hash)
    { page: parse_from_page(repo_id), api: response_from_api(client, repo_id) }
  end

  # :reek:UtilityFunction:
  def parse_uri_of(info)
    return nil if info.empty?

    url = (info['source_code_uri'] || info['homepage_uri']).split('/')
    { user: url[3], repo: url[4] }
  end

  def parse_from_page(repo_id)
    url = 'https://github.com/' + repo_id[:user] + '/' + repo_id[:repo]
    contributors = find_contributors(url)
    url += '/network/dependents'
    { contributors: contributors, used_by: find_used_by(url) }
  end

  def response_from_api(client, repo_id)
    client.repo repo_id
  rescue Octokit::InvalidRepository
    raise 'Invalid as a repository identifier.'
  end

  # rubocop:disable Security/Open
  def find_contributors(url)
    Nokogiri::HTML(open(url)).css('span.num.text-emphasized').children[2].text.to_i
  end

  def find_used_by(url)
    Nokogiri::HTML(open(url)).css('.btn-link')[1].text.delete('^0-9').to_i
  end
  # rubocop:enable Security/Open
end
