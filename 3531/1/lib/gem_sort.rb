class GemSort
  attr_reader :sorted_gems

  def initialize(gems)
    @sorted_gems = sort_gems(gems)
  end

  private

  def sort_gems(gems)
    gem_scores = []

    gems.each { |gem| gem_scores << [gem.score, gem.name, gem] }
    gem_scores.sort.reverse
  end
end
