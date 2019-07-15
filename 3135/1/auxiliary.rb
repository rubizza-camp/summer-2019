require 'YAML'
require 'table_print'

private

def load_list(file = nil)
  YAML.load_file(file || 'gem_list.yml')['gems']
end

def check_names(list, name = nil)
  seq = options[:name]
  return list.select! { |name| name.include? seq } if seq

  list
end

def check_top(gems, options)
  num = options[:top]
  return gems[1..num] if num && gems.length > num

  gems
end

def print_table(gems)
  tp(gems, :name, :used_by, :watch, :star, :fork, :issues, :contributors,
     rating: { display_name: 'total downloads' })
end
