class CafeController < ApplicationController
  get '/' do
    @places = Place.all
    erb :show_all_places
  end

  post '/login' do
    if AuthHelper.chek_user_email(params[:email])
      if AuthHelper.check_valid_user_password(params[:password], params[:email])
        add_user_info_to_cookies(params[:email])
        cookies.delete(:info)
        redirect @env['HTTP_REFERER']
      end
      cookies[:info] = 'Wrong email or password!!'
      redirect @env['HTTP_REFERER']
    end
    cookies[:info] = 'Wrong email or password!!'
    redirect @env['HTTP_REFERER']
  end

  post '/logout' do
    delete_cookies(:info, :user_name, :users_id)
    redirect @env['HTTP_REFERER']
  end

  post '/register' do
    cookies.delete(:info)
    User.create(name: params[:name], email: params[:email],
                password: BCrypt::Password.create(params[:password]))
    redirect @env['HTTP_REFERER']
  end

  get '/place/:id' do
    @reviews = Review.where(['places_id = ?', params[:id]])
    @place = Place.find(params[:id])
    @user_names = []
    @reviews.each { |review| @user_names << User.where('id = ?', review.users_id).first.name }
    erb :show_place
  end

  post '/place/:id' do
    Review.create(title: params[:title], description: params[:description],
                  places_id: params[:id], users_id: cookies[:users_id],
                  rating: params[:rating])
    Place.find(params[:id]).update(average_rating:
                                    RatingHelper.calculate_average_rating(params[:id]))
    redirect "/place/#{params[:id]}"
  end
end
