require_relative 'gemlist.rb'

# Prepare gemlist for display
class TopRubyGems < GemList
  def self.pick_names(text)
    matched_name = make_gemlist.select { |gem| gem.name.include?(text) }
    sort_gems(matched_name)
  end

  def self.top_gems
    sort_gems(make_gemlist)
  end

  def self.sort_gems(list)
    list.sort_by(&:star).reverse!
  end
end
