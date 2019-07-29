require 'yaml'

module Scanner
  class Yaml
    attr_reader :parsed_data

    def initialize(path)
      @path = path.to_s
      @parsed_data = []
    end

    def scan
      @parsed_data = YAML.load_file(@path)['gems']
    rescue Errno::ENOENT => er
      puts er.message
      exit
    end
  end
end
