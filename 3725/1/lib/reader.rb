require 'yaml'
require 'optparse'
require 'mechanize'

module Reader

  class File

    def read
      YAML.load_file('gemlist.yml')['gems']
    end

  end

  class Shell

    def load_parameters
        ARGV.each_with_object({}) do |parameters, hash|
          split = parameters.delete('-').split('=')
          hash[split.first.to_sym] = split.last
        end
    end
    def read
      options = {}
    end

  end

end
