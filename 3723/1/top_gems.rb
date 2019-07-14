require_relative 'repo'
require_relative 'pages'
require_relative 'cli'
require 'optparse'

options = Cli.parse(ARGV)

doc = if options[:file]
        YAML.load_file(options[:file])
      else
        YAML.load_file('gems.yml')
      end

list = Repo.new
list.take_repo(doc)

html = Pages.new

if options[:number]
  html.save_htmls(list.list.first(options[:number].to_i))
else
  html.save_htmls(list.list)
end

html.take_content(html.htmls)
html.represent_info
