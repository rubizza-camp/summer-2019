require_relative 'gem_list_fetcher.rb'
require_relative 'ruby_gem.rb'

# Prepare gemlist for display
class TopRubyGems
  class << self
    def make_gemlist
      GemListFetcher.read_from_file.map { |title| RubyGem.new(title) }
    end

    def pick_names(text)
      matched_name = make_gemlist.select { |gem| gem.name.include?(text) }
      sort_gems(matched_name)
    end

    def top_gems
      sort_gems(make_gemlist)
    end

    def sort_gems(list)
      list.sort_by(&:star).reverse!
    end
  end
end
