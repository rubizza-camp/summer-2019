Dir[File.dirname(__FILE__) + '/top-gems/*.rb'].each { |file| require file }
# This is a main class that collect all service objects
require 'gems'
# :reek:TooManyStatements
module TopGems
  class MainTopGems
    def self.start
      options = OptionsParser.call
      gems_names = FileWithYamlParser.call(options)
      results = generaion_stats(gems_names)
      PresentStats.call(results, options)
    end

    def self.generaion_stats(gems_names)
      gems_names.map do |name_of_the_gem|
        stats = StatsOfGemParser.call(Gems.info(name_of_the_gem)['source_code_uri'])
        rate = RateCount.call(stats)
        stats[:rate] = rate
        stats[:name] = name_of_the_gem
        stats
      end
    end
  end
end
