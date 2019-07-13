# class for initialization parametrs, for open file with names of gems and for..
class DataInitializer
  # create object for InvalidArgumentError error
  InvalidArgumentError = Class.new(StandardError)

  attr_reader :argv
  attr_reader :hash_argv, :array_name_gems

  def initialize
    @argv = ARGV

    @hash_argv = {
      top: nil,
      name: nil,
      file: 'gems.yml'
    }

    @array_name_gems = []
  end

  def getting_parameters
    argv.each do |argv|
      parametr = argv.split('=')
      parametr_name = parametr[0].gsub(/[^A-za-z]/, '').to_sym
      unless hash_argv.include? parametr_name
        raise InvalidArgumentError, 'Please, enter the correct parameters.'
      end
      hash_argv[parametr_name] = parametr[1]
    end
  end

  def open_file_with_names_of_gems
    text = File.open(hash_argv[:file]).read
    text.each_line do |line|
      name_gem = line.gsub(/[^A-za-z]/, '')
      array_name_gems << name_gem if name_include_parameter_name?(name_gem)
    end
    array_name_gems.shift if array_name_gems[0] == 'gems'
  end

  private

  def name_include_parameter_name?(name)
    parm_name = hash_argv[:name]
    return true unless parm_name
    name.include?(parm_name)
  end
end
