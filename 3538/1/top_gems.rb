require 'yaml'

def server_info
  yml = YAML::load(open('gems-names.yml'))
  puts yml['gems']['gem1']['name']
end

server_info
