# frozen_string_literal: true

require './lib/github_links_loader.rb'
require './lib/github_login.rb'
require './lib/gem_data_parser.rb'
require './lib/sorter.rb'
require './lib/console_output.rb'
require 'bundler'
Bundler.require

class TopGems
  def initialize
    @gems_data = []
  end

  def collect_all_data
    @gems_data = GithubLinksLoader.new.yml_gems
    agent = GithubLogin.new.auth
    gems_stat = GemDataParser.new(agent).parse_gem_data(@gems_data)
    final_stat = Sorter.new(gems_stat).sort
    ConsoleOutput.new.console_output(final_stat)
  end
end
TopGems.new.collect_all_data
