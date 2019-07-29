class GemList
  def initialize(options)
    @file = options[:file]
    @argument_name = options[:name]
  end

  def list_of_gem
    hash_of_gem.delete_if { |name| !name.include?(@argument_name) }
  rescue NoMethodError
    raise FileError, "#{@file} is empty use other file or fill this"
  end

  private

  def hash_of_gem
    YAML.safe_load(File.read(@file))['gems']
  rescue Errno::ENOENT
    raise FileError, "#{@file} not found"
  end
end
