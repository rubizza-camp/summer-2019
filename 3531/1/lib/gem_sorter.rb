class GemSorter
  def call(gems)
    gems.map { |gem| [gem.score, gem.name, gem] }.sort.reverse
  end
end
