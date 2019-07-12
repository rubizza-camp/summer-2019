require 'json'
require 'yaml'
require 'faraday'
require 'nokogiri'
require 'open-uri'
require_relative './repo_list'

class RepoPage
  attr_accessor :list_info
  attr_reader :name

  def initialize(name)
    @list_info = []
    @name = name
  end

  def used_by(repo)
    net = "#{repo}/network/dependents"
    doc = Nokogiri::HTML.parse(open(net))
    doc.css('.btn-link').css('.selected').text.split(/[^\d]/).join
  end

  def watch(repo)
    doc = Nokogiri::HTML.parse(open(repo))
    doc.css('.social-count').first.text.strip
  end

  def stars(repo)
    doc = Nokogiri::HTML.parse(open(repo))
    doc.css('.social-count').css('.js-social-count').last.text.strip
  end

  def forks(repo)
    doc = Nokogiri::HTML.parse(open(repo))
    doc.css('.social-count').last.text.strip
  end

  def contributors(repo)
    doc = Nokogiri::HTML.parse(open(repo))
    doc.css('.num').css('.text-emphasized').last.text.strip
  end

  def issues(repo)
    doc = Nokogiri::HTML.parse(open(repo))
    doc.css('.Counter').first.text.strip
  end

  def represent_info(list)
  list.compact.map do |repo|
      response = Faraday.get repo.to_s
      name = repo.split('/').last
      @list_info << issues(repo)
  end
  end
end

doc = YAML.load_file('ruby_gems.yml')
gem_list = RepoList.new('new_list')
gem_list.take_repo(doc)

repo_info = RepoPage.new('new_info')
repo_info.represent_info(gem_list.list)
puts repo_info.list_info

