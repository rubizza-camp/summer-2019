# class for open file with names of gems
class ArrayNamesGemsCreator
  def array_names_of_gems(options)
    hash = YAML.load_file(options[:file])
    array_names_gems = hash['gems']
    array_names_gems.delete_if { |gem_name| !name_of_gem_include_argv_name?(gem_name, options) }
    array_names_gems
  end

  private

  def name_of_gem_include_argv_name?(name, options)
    return true unless options[:name]
    name.include?(options[:name])
  end
end
