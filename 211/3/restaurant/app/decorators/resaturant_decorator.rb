module RestaurantDecorator
  def rating
    if reviews.average(:mark).nil?
      'nobody marks us yet'
    else
      reviews.average(:mark).round(2)
    end
  end

  def short_description
    description.slice(0..(description.index("\n")))
  end

  def latitude
    location.split(',')[0]
  end

  def longtitude
    location.split(',')[1]
  end
end
