require 'YAML'

private

def load_list(options)
  YAML.load_file(options[:file] || 'gem_list.yml')['gems']
end

