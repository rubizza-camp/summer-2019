require 'YAML'
require 'table_print'

# :reek:UtilityFunction
def load_list(file)
  YAML.load_file(file)['gems']
end

# :reek:UtilityFunction
def check_names(list, sequence)
  return list.select! { |name| name.include? sequence } if sequence

  list
end

# :reek:UtilityFunction
def check_top(list, num)
  return list.first(num) if num

  list
end

def print_table(gems)
  tp(gems, :name, :used_by, :watches, :stars, :forks, :issues, :contributors, :downloads)
end
