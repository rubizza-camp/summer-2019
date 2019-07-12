require 'yaml'

module Scanner
  class Yaml
    def initialize(path)
      @path = path || 'rubygems.yml'
    end

    def scan
      load_yaml['gems']
    rescue Errno::ENOENT => error
      puts error.message
      []
    end

    private

    def load_yaml
      YAML.load_file(@path)
    end
  end
end
