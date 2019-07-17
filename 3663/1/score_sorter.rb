class ScoreSorter
  private

  def convert_stat_to_score(stat)
    score = 0
    stat.each do |value|
      score += value.delete(',').to_i / 1000
    end
    score
  end

  def sort_gems_data_array(gems_data_array)
    gems_data_array.sort_by! { |gem_hash| gem_hash[:gem_score] }.reverse!
    gems_data_array.each { |gem_hash| gem_hash.delete(:gem_score) }
  end
end
