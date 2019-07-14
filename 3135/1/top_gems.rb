require_relative 'options'
require_relative 'gem_class'
require_relative 'auxiliary'

# -----------first things first
options = parse_options # check option flags
list = load_list(options) # read yml. file into array (--file)
list = check_names(list, options) # select gems with --name included (--name)
# -----------gemdata population
gems = []
list.each { |name| gems << GemData.new(name) }
gems.each do |gem|
  gem.call_rubygems_api # these should be private and be called within the class(?)
  gem.rating_stat
  gem.github_link
  gem.github_parse
end
# -----------last but not the least
gems.sort_by!(&:rating).reverse! # sort by number of downloads. Should it be a method?
gems = check_top(gems, options) # shrink list according to --top flag value
print_table(gems) # print nice looking table
