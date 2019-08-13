module RateCalculator
  def self.call(id)
    comments = Review.where(bar_id: id)
    bar_rate = comments.map(&:rating)
    median(bar_rate)
  end

  # :reek:UtilityFunction
  def self.median(array)
    sorted = array.sort
    len = sorted.length
    (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
  rescue NoMethodError
    "Nobody didn't rated this place before"
  end
end
