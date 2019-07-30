# :reek:UtilityFunction:
# :reek:ControlParameter:
# Utils module with all the tools for this app
module Utils
  def find_active_user(id)
    return User.find(id) if id

    nil
  end

  def activate_user(id)
    session[:id] = id
  end

  # :reek:DuplicateMethodCall:
  def login(email, password)
    if User.exists?(email: email) && User.find_by(email: email)[:password] == password
      activate_user(User.find_by(email: email)[:id])
      session[:return_to_page]
    else
      flash.next[:error] = '!!wrong email/password combo!!'
      '/login'
    end
  end

  def registration(params)
    user = User.new(params)
    if user.save
      activate_user(user[:id])
      session[:return_to_page]
    else
      flash.next[:error] = '!!wrong input!!'
      '/registration'
    end
  end

  # :reek:DuplicateMethodCall:
  def calculate_average_rating(restaurant)
    return '-' if restaurant.reviews.empty?

    review_ratings = restaurant.reviews.map { |review| review[:rating] }
    review_ratings.inject(:+).fdiv(review_ratings.length).round(1)
  end

  def add_review(params)
    review = Review.new(params)
    if review.save
    else
      flash.next[:error] = review.errors[:description].last
    end
    session[:return_to_page]
  end
end
