require 'yaml'
# Reads gem list from the input file
module TopGems
  class FileWithYamlParser
    def self.call(options)
      new.read(options)
    end

    def read(options)
      gems_names = YAML.load_file(options[:path])
      define_names(gems_names, options)
    rescue Errno::ENOENT
      puts 'Wrong path to file, please try another. Check your gems.yml'
      raise
    end

    private

    # :reek:FeatureEnvy
    def define_names(arr_of_gems_names, options)
      if options_given?(options)
        arr_of_gems_names['gems'].select! { |gem| gem.match(options[:name]) }
      else
        arr_of_gems_names['gems']
      end
    end

    def options_given?(options)
      if options[:name].to_s.empty?
        false
      else
        true
      end
    end
  end
end
