module RestaurantHelper
  def average_cafe_mark
    @average_mark = Comment.where(place_id: session[:rest_id]).average(:grade).to_f
  end

  def info_about_selected_cafe
    session[:cafe_name] = params[:name]
    @rest = Restaurant.all.find_by(name: params[:name])
    session[:rest_id] = @rest.id
    average_cafe_mark
  end

  def good_mark?
    params[:rate].to_i > 2
  end

  def ask_about_comment
    return if comment?

    please_add_comment
  end

  def comment?
    params[:text].length > 1
  end
end
