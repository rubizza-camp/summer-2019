require 'yaml'

def list_gems
  gems_names = YAML::load(open('gems-names.yml'))
  gems_names.each do |gem|
    puts gem
  end
end

list_gems
