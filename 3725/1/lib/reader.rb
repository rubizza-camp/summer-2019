require 'yaml'
require 'optparse'
require 'mechanize'

module Reader
  class File
    def initialize(file_path)
      @file_path = file_path || 'gemlist.yml'
    end

    def read
      YAML.load_file(@file_path)['gems']
    end
  end

  class Shell
    def load_parameters
        ARGV.each_with_object({}) do |parameters, hash| # rubocop:disable Layout/IndentationWidth
          split = parameters.delete('-').split('=')
          hash[split.first.to_sym] = split.last
        end
    end
  end
end
