require 'optparse'
# This is service class for caughting options.
module TopGems
  class OptionsParser
    attr_reader :opts

    def self.call
      new.opts
    end

    def initialize
      @opts = { path: './lib/data/gems.yml' }
      parse.parse!
    end

    private

    def get_top_value(options)
      options.on('-t', '--top NUMBER') { |num| opts[:number] = num.to_i }
    end

    def get_name_value(options)
      options.on('-n', '--name NAME') { |name| opts[:name] = name }
    end

    def get_file_value(options)
      options.on('-f', '--file FILE') { |path| opts[:path] = path }
    end

    def parse
      OptionParser.new do |options|
        get_top_value(options)
        get_name_value(options)
        get_file_value(options)
      end
    end
  end
end
