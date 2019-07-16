require 'yaml'
require 'gems'

class YamlReader
  attr_reader :file

  def initialize(filepath)
    @filepath = filepath
  end

  def parse
    correct(adress_of_source_code(read_yaml))
  end

  private

  def read_yaml
    file = YAML.load_file(@filepath)
    file['gems'].delete('-').split(' ')
  rescue Errno::ENOENT
    puts 'File doesn\'t exist. \n Enter correct file\'s adress'
    @filepath = gets.chomp
    retry
  end

  def correct(adresses)
    adresses.map do |adress|
      redirect(adress)
    end
  end

  def redirect(adress)
    if adress[0..4].include?('s')
      adress
    else
      string = adress[4..adress.length]
      "https#{string}"
    end
  end

  def adress_of_source_code(gems)
    gems.map do |item|
      Gems.info(item)['source_code_uri']
    end
  end
end
