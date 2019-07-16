require_relative 'repo'
require_relative 'pages'
require 'optparse'

options = {}

OptionParser.new do |parser|
  parser.on('-t', '--top=NUMBER') do |number|
    options[:number] = number
  end
  parser.on('-n', '--name=NAME') do |name|
    options[:name] = name
  end
  parser.on('-f', '--file=FILE') do |file|
    options[:file] = file
  end
end.parse!

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
