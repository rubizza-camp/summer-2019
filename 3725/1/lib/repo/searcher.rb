require 'octokit'
require 'optparse'
require 'mechanize'

module Repo
  class Searcher
    def self.call(gem_name:, client:)
      client.search_repositories(gem_name).items.first
    end
  end
end
