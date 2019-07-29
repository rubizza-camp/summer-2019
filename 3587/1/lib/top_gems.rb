class TopGem
  attr_reader :options

  def initialize(options, agent)
    @options = options
    @agent = agent
  end

  def self.perform
    new(ParseOption.call, Mechanize.new).perform
  end

  def perform
    array_of_gems = GemList.new(options).list_of_gem
    hash_gem = parse(array_of_gems)
    Output.new(hash_gem, options[:top]).print
  end

  def parse(array_of_gems)
    array_of_gems.each_with_object({}) do |gem, hash|
      hash_with_stat = Scraper.new(gem, @agent).hash_with_info_about_gem
      hash_with_stat[:score] = AnalyzerGems.new(hash_with_stat).score_of_gems
      hash[gem] = hash_with_stat
    rescue MechanizeError
      puts "problems with #{gem}"
    end
  end
end
