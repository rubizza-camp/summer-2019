require_relative 'gem_list_fetcher.rb'
require_relative 'ruby_gem.rb'

# Making a list of gems
class GemList
  def self.make_gemlist
    GemListFetcher.new.read_from_file.map { |title| RubyGem.new(title) }
  end
end
