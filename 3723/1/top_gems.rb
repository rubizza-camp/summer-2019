require_relative './repo_list'
require_relative './pages'
require 'optparse'

doc = YAML.load_file('ruby_gems.yml')
gem_list = RepoList.new
gem_list.take_repo(doc)

html = Pages.new
html.save_htmls(gem_list.list)
html.take_content(html.htmls)
html.represent_info
