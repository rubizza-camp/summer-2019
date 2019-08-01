module PlaceHelper
  def load_place_info
  	session[:place_name] = params[:name]
    @place = Place.all.find_by(name: params[:name])
    session[:place_id] = @place.id
  end

  def rate_place
  	redirect '/login' unless login?
  	comment
  end

  def comment
  	@user = User.find(session[:user_id])
  	@comment = Comment.new
    @comment = @user.comments.create(rating: params[:rate].to_i, text: params[:text])
    save_comment
  end

  def save_comment
  	@comment.place_id = session[:place_id].to_i
    @comment.save!
  end

  def count_rating
  	@average_rating = Comment.where(place_id: session[:place_id]).average(:rating).to_f
  end

  def login?
    session[:user_id]
  end
end
