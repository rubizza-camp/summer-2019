require_relative 'gemlist.rb'

# Prepare gemlist for display
class TopRubyGems < GemList
  def self.pick_names(text)
    matched_name = make_gemlist.map { |ruby_gem| ruby_gem if ruby_gem.name.include?(text) }.compact!
    sort_gems(matched_name)
  end

  def self.top_gems
    sort_gems(make_gemlist)
  end

  def self.sort_gems(list)
    list.sort_by { |ruby_gem| - ruby_gem.star }
  end
end
