require 'yaml'
require 'gems'

# :reek:TooManyStatements
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength
class YamlReader
  attr_reader :file

  def initialize(file)
  	@file = file
  end

  def parse
    read_file(@file)
  end

  private

  def read_file(given_file)
    adresses = []
    gems = []
    array = {}
    begin 
      file = YAML.load_file(given_file)
    rescue
      puts 'File Error'
      abort
    end
    file['gems'].to_s.split(' ').each do |element|
      element.delete!('-')
      gems << element
      github_url = Gems.info element
      adress = github_url['source_code_uri']
      if adress[0..4].include?('s')
        adresses << adress
      else
        string = adress[4..adress.length]
        new_adress = "https#{string}"
        adresses << new_adress
      end
    end
    array[:gems] = gems
    array[:adress] = adresses
    array
  end
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength
