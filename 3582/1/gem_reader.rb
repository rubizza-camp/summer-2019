require 'yaml'

# Read gem names from file
class GemReader
  def initialize(file_name)
    @file = file_name
  end

  def execute
    open_file
  end

  private

  def open_file
    begin
      raise Errno::ENOENT unless @file.is_a?(String)

      gem_names = YAML.load_file(@file).dig('gems')
    rescue Errno::ENOENT
      gem_names = %w[sinatra rspec rails nokogiri]
      puts "File Doesn't exist or not specifeid, loading deafult gems"
    end
    gem_names
  end
end
