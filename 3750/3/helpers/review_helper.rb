require 'sinatra/base'

module ReviewHelper
  def already_reviewed?
    Review.find_by(user_id: session[:user_id])
  end

  def user_logged?
    session[:user_id]
  end

  def create_review
    @user = User.find(session[:user_id])
    @review = @user.reviews.create(grade: params[:grade].to_i, text: params[:text])
    @review.restaurant_id = @restaurant.id
  end

  def review_validation_info
    if @review.valid?
      @review.save
      'Review created!'
    else
      'You need to enter more text before publishing!'
    end
  end
end
