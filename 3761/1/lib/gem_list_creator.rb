class GemListCreator
  def self.call(args = {})
    new(args).call
  end

  attr_reader :file_name, :name_substring

  def initialize(args = {})
    @file_name = args[:file]
    @name_substring = args[:name]
  end

  def call
    gem_list.select { |gem_name| gem_name.include? name_substring }
  end

  private

  def gem_list
    read_file if File.file?(file_name)
  end

  def read_file
    YAML.load_file(file_name)['gems']
  end
end
