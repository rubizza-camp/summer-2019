require 'yaml'

module Scanner
  class Yaml
    def initialize(args)
      @path = args['file'] || 'rubygems.yml'
      @name_filter = args['name']
      @gem_names = []
    end

    def scan
      load_yaml
    rescue Errno::ENOENT => error
      puts error.message
      []
    end

    private

    def load_yaml
      @gem_names = YAML.load_file(@path)['gems']
      filter_by_name if @name_filter
      @gem_names
    end

    # Filter gems from file by --name value from shell
    def filter_by_name
      @gem_names.dup.each do |name|
        @gem_names.delete(name) unless name.match(Regexp.new(@name_filter))
      end
      @gem_names
    end
  end
end
