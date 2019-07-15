# class for initialization parametrs, for open file with names of gems and for..
class DataInitializer
  # create object for InvalidArgumentError error
  InvalidArgumentError = Class.new(StandardError)

  # attr_reader :array_names_gems
  attr_reader :hash_argv

  def initialize
    @hash_argv = {
      top: nil,
      name: nil,
      file: 'gems.yml'
    }

    @array_names_gems = []
  end

  def hash_arguments
    ARGV.each do |argvs|
      name, value = argvs.split('=')
      name = name.gsub(/[^A-za-z]/, '').to_sym
      unless hash_argv.include? name
        raise InvalidArgumentError, 'Please, enter the correct parameters.'
      end
      hash_argv[name] = value
    end
  end

  def array_names_of_gems
    hash = YAML.load_file(hash_argv[:file])
    array_names_gems = hash['gems']
    array_names_gems.delete_if { |gem_name| !name_of_gem_include_argv_name?(gem_name) }
    array_names_gems
  end

  private

  def name_of_gem_include_argv_name?(name)
    return true unless hash_argv[:name]
    name.include?(hash_argv[:name])
  end
end
