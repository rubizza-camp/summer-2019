require_relative 'options'
require_relative 'gem_class'
require_relative 'auxiliary'

# -----------first things first
options = parse_options # check option flags
list = load_list(options[:file]) # read yml. file into array (--file)
list = check_names(list, options[:name]) # select gems with --name included (--name)
# -----------gemdata population
list.map! { |name| GemData.new(name) }
list.each(&:populate)
# -----------last but not the least
list.sort_by!(&:downloads).reverse! # sort by number of downloads. Should it be a method?
list = check_top(list, options[:top]) # take first --top flag value elements of the list
print_table(list) # print nice looking table
#-------------
