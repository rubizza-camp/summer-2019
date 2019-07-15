require 'yaml'
require 'gems'

class YamlReader
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def parse
    check_file(@file)
    adress_of_source_code(read_yaml)
  end

  private

  def check_file(file)
    raise ArgumentError if file.split('.').last != 'yaml'
  end

  def read_yaml
    begin
      file = YAML.load_file(@file)
    rescue StandardError
      puts 'File doesn\'t exist'
      abort
    end
    file['gems'].to_s.split(' ').each do |item|
      item.delete!('-')
    end
  end

  def correct(adresses)
    adresses.map do |adress|
      make_redirection(adress)
    end
  end

  def make_redirection(adress)
    if adress[0..4].include?('s')
      adress
    else
      string = adress[4..adress.length]
      "https#{string}"
    end
  end

  def adress_of_source_code(gems)
    adresses = []
    gems.select do |item|
      github_url = Gems.info item
      adresses << github_url['source_code_uri']
    end
    correct(adresses)
  end
end
