require 'faraday'
require 'json'
require 'nokogiri'
require 'open-uri'

class NotFoundError < StandardError; end
class BadGatewayError < StandardError; end

class RepoBody
  attr_reader :name, :doc, :used_by_doc, :git_url

  def initialize(gem_name, internet = Kernel)
    @name = gem_name
    @net = internet
  end

  def fetch_params
    @git_url = set_git_url
    @doc = fetch_doc
    @used_by_doc = fetch_used_by_doc
  end

  private

  def set_git_url
    gem_url = "https://rubygems.org/api/v1/gems/#{@name}.json"

    res = Faraday.get(gem_url)
    handle_errors(res)

    res_params = JSON.parse(res.body)
    fetch_url(res_params)
  end

  def handle_errors(res)
    raise NotFoundError if res.status == 404
    raise BadGatewayError if res.status == 502
  rescue NotFoundError
    warn '404 gem not found'
    abort
  rescue BadGatewayError
    warn 'bad gateway error, please restart the script'
    abort
  end

  def fetch_url(res_params)
    git_url = res_params['source_code_uri'] if res_params['source_code_uri']
    git_url = res_params['homepage_uri'] if res_params['homepage_uri']&.include?('https://github')

    git_url.delete_suffix!('/')
    git_url
  rescue NotFoundError
    warn 'git url is not found'
    abort
  end

  def fetch_doc
    Nokogiri::HTML(@net.open(@git_url))
  rescue SocketError
    warn 'tcp connection error'
    abort
  rescue Errno::ENOENT
    warn 'gem without git link'
    abort
  end

  def fetch_used_by_doc
    case @git_url.count('/')
    when 0...5
      Nokogiri::HTML(@net.open("#{@git_url}/network/dependents"))
    else
      res = edit_url
      url = res[0]
      contributors_doc = res[1]
      used_by_doc = Nokogiri::HTML(@net.open(url))
      [used_by_doc, contributors_doc]
    end
  end

  def edit_url
    url = @doc.css("a[data-pjax='#js-repo-pjax-container']").map { |nd| nd['href'] }.join('')
    base_url = 'http://github.com' + url
    sub_gem_url(base_url)
  end

  def sub_gem_url(base_url)
    url = "#{base_url}/network/dependents"
    doc = Nokogiri::HTML(@net.open(url))
    base_doc = Nokogiri::HTML(@net.open(base_url))
    elem = doc.css('a.select-menu-item.js-navigation-item')
    used_by_url = elem.map { |nd| nd['href'] if nd.text.delete("'' \n") == name }
    used_by_url = used_by_url.compact.join('')
    final_url = 'http://github.com' + used_by_url
    [final_url, base_doc]
  end
end
