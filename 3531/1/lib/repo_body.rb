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
    @internet = internet
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
  rescue BadGatewayError => ex
    puts ex.message
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
    Nokogiri::HTML(@internet.open(@git_url))
  rescue SocketError
    warn 'tcp connection error'
    abort
  rescue Errno::ENOENT
    warn 'gem without git link'
    abort
  end

  def fetch_used_by_doc
    Nokogiri::HTML(@internet.open("#{@git_url}/network/dependents"))
  end
end
