def main
  gems_names = YAML::load(open("#{@yml_file}"))['gems']
  gems_names.each do |gem|
    owner = get_owner(gem)
    gem_data = get_data(owner,gem)
    print_data(gem,gem_data)
  end
end

def params_file
  input_array = ARGV
  if input_array.length > 0 && input_array.select {|par| par.include?"--file"}
    param_file = input_array.select {|par| par.include?"--file"}.to_s.delete '[]"'
    @yml_file = param_file.delete_prefix!('--file=')
  end
end
