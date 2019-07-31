module ReviewHelper
  STAR = '&#9734;'.freeze
  EMPTY_STAR = '&#9733;'.freeze

  # :reek:all

  def review_statistic(avg_rate)
    Array.new(5, EMPTY_STAR).fill(STAR, avg_rate).join(' ')
  end
end
