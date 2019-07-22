class TopFunction
  def call(data, from_file)
    reordered_gems = gems_by_rating(data)
    top_function(from_file, reordered_gems)
    reordered_gems
  end

  private

  def gems_by_rating(data)
    data.sort_by { |_, value| value }.reverse
  end

  def top_function(from_file, reordered_gems)
    reordered_gems.take(from_file[:top].to_i) unless from_file[:top]
  end
end
