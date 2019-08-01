class UsersController < Sinatra::Base
  use Rack::Flash

  get '/sign_in' do
    return redirect '/' if session?
    erb :sign_in
  end

  post '/sign_in' do
    @user = User.find_by(email: params['email'])
    if @user && @user.password == params[:password]
      session_start!
      session[:user_id] = @user.id
      redirect '/'
    else
      flash[:error] = I18n.t(:incorrect_sign_in)
      redirect '/sign_in'
    end
  end

  post '/sign_out' do
    session_end!
    redirect '/'
  end

  get '/sign_up' do
    return redirect '/main' if session?
    erb :sign_up
  end

  post '/sign_up' do
    @user = User.new(params.slice(:name, :email, :password))
    if @user.valid? && params[:password] == params[:password_confirmation]
      @user.save
      session_start!
      session[:user_id] = @user.id
      redirect '/'
    else
      flash[:error] = I18n.t(:incorrect_sign_up)
      redirect '/sign_up'
    end
  end
end
