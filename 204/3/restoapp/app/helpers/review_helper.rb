module ReviewHelper
  # :reek:all
  def review_statistic(avg_rate)
    Array.new(5, '&#9733;').fill('&#9734;', avg_rate).join(' ')
  end
end
