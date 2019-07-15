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

repo = Repo.new
repo.take_repo(doc)

page = Pages.new
page.save_htmls(repo.list)
page.take_content(page.htmls)

if options[:number]
  page.sort_by_number(options[:number].to_i)
elsif options[:name]
  page.sort_by_name(options[:name].to_s)
end

page.represent_info
