class CafeController < ApplicationController
  get '/' do
    @pagy, @places = pagy(Place.all, items: 10)
    erb :show_all_places
  end

  post '/login', needs: %i[email password] do
    if User.find_by(['email = ? ', email])
      if PasswordService.valid_user_password?(params[:password], params[:email])
        user = User.where(['email = ?', params[:email]]).first
        cookies[:users_id] = user[:id]
        cookies[:user_name] = user[:name]
        redirect @env['HTTP_REFERER']
      end
      cookies[:info] = 'Wrong email or password!!'
      redirect @env['HTTP_REFERER']
    end
    cookies[:info] = 'Wrong email or password!!'
    redirect @env['HTTP_REFERER']
  end

  post '/logout' do
    cookies.delete(:info)
    cookies.delete(:user_name)
    cookies.delete(:users_id)
    redirect @env['HTTP_REFERER']
  end

  post '/register', needs: %i[email password name] do
    cookies.delete(:info)
    User.create_user(params[:email], params[:name], params[:password])
    redirect @env['HTTP_REFERER']
  end

  get '/place/:id' do
    @place = Place.where(id: params[:id])
    erb :show_place
  end

  get '/place/:id/review' do
    @reviews = Place.where(id: params[:id]).first.reviews
    erb :reviews
  end

  post '/place/:id/review', needs: %i[title description rating] do
    Review.create_review(
      title: params[:title],
      description: params[:description],
      place_id: params[:id],
      user_id: cookies[:users_id],
      rating: params[:rating]
    )
    Place.update_place_by_id(params[:id])
    @reviews = Place.where(id: params[:id]).first.reviews
    erb :reviews
  end
end
