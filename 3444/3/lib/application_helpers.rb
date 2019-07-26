module ApplicationHelpers
  def useremail
    if session['warden.user.default.key']
      User.first(id: session['warden.user.default.key']).useremail
    else
      false
    end
  end

  def calculate_rate(id)
    comments = Comment.all(bar_id: id)
    bar_rate = comments.map(&:rate)
    median(bar_rate)
  end

  # Desable cause i don't know where to move this, can you help me?
  #:reek:UtilityFunction
  def median(array)
    sorted = array.sort
    len = sorted.length
    (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
  rescue NoMethodError
    "Nobody didn't rated this place before"
  end
end
