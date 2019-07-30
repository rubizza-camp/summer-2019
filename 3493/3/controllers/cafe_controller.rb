class CafeController < ApplicationController
  get '/' do
    @pagy, @places = pagy(Place.all, items: 10)
    erb :show_all_places
  end

  post '/login', needs: %i[email password] do
    if UserHelper.chek_user_email(params[:email])
      if UserHelper.valid_user_password?(params[:password], params[:email])
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

  post '/register', needs: %i[email password name] do
    cookies.delete(:info)
    UserHelper.create_user(params[:email], params[:name], params[:password])
    redirect @env['HTTP_REFERER']
  end

  get '/place/:id' do
    @place = Place.where(id: params[:id])
    if @place.empty?
      redirect '/'
    else
      erb :show_place
    end
  end

  post '/place/:id' do
    ReviewHelper.create_review(
      title: params[:title],
      description: params[:description],
      place_id: params[:id],
      user_id: cookies[:users_id],
      rating: params[:rating]
    )
    Place.find(params[:id]).update(average_rating:
                                    RatingHelper.calculate_average_rating(params[:id]))
    redirect "/place/#{params[:id]}"
  end
end
