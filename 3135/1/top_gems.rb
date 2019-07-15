require_relative 'options'
require_relative 'gem_class'
require_relative 'auxiliary'

# -----------first things first
options = parse_options # check option flags
list = load_list(options[:file]) # read yml. file into array (--file)
list = check_names(list, options[:name]) # select gems with --name included (--name)
# -----------gemdata population
#gems = list.map { |name| GemData.call(name) }


#a = GemData.new('sinatra')
#a.populate
#puts [a.rating, a.github_link, a.watch, a.star, a.forks, a.issues, a.contributors]

#puts a.name
# list.each { |name| gems << GemData.new(name) }


#puts GithubParseService.call('https://github.com/sinatra/sinatra')
a = GemData.new('sinatra')
puts a.populate('https://github.com/sinatra/sinatra')


# -----------last but not the least
# gems.sort_by!(&:rating).reverse! # sort by number of downloads. Should it be a method?
# gems = check_top(gems, options) # shrink list according to --top flag value
# print_table(gems) # print nice looking table
