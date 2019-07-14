require 'YAML'

def load_list(options)
  YAML.load_file(options[:file] || 'gem_list.yml')['gems']
end

def check_names(list, options)
  return list.select! { |name| name.include? options[:name] } if options[:name]

  list
end

def check_top(gems, options)
  num = options[:top]
  return gems[1..num] if num && gems.length > num

  gems
end
