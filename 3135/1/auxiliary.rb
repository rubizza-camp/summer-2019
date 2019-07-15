require 'YAML'
require 'table_print'

private

def load_list(file)
  YAML.load_file(file || 'gem_list.yml')['gems']
end

def check_names(list, sequence)
  return list.select! { |name| name.include? sequence } if sequence

  list
end

def check_top(gems, num = nil)
  return gems.first(num) if num

  gems
end

def print_table(gems)
  tp(gems, :name, :used_by, :watch, :star, :fork, :issues, :contributors,
     rating: { display_name: 'total downloads' })
end
