require_relative 'gem_list.rb'

# Prepare gemlist for display
class TopRubyGems < GemList
  class << self
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
