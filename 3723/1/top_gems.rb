require_relative './repo_list'
require_relative './repo_page'
require 'optparse'

doc = YAML.load_file('ruby_gems.yml')
gem_list = RepoList.new('new_list')
gem_list.take_repo(doc)

repo_info = RepoPage.new('new_info')
repo_info.represent_info(gem_list.list)
