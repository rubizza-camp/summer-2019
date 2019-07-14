class Rating
  def self.sort_gems_arr_by_score(gem_arr)
    gem_arr.sort { |fgem, sgem| -1 * (fgem.score <=> sgem.score) }
  end
end
