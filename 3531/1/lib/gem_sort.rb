class GemSort
  def initialize(gems)
    @gems = gems
  end

  def call
    sort_gems
  end

  private

  def sort_gems
    @gems.map { |gem| [gem.score, gem.name, gem] }.sort.reverse
  end
end
