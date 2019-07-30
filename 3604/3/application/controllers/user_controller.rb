class UserController < Sinatra::Base
  use Rack::Flash

  get '/sign_in' do
    if session?
      redirect '/main'
    else
      erb :sign_in
    end
  end

  post '/sign_in' do
    @user = User.find_by(email: params['email'])
    if @user && @user.password == params[:password]
      session_start!
      session[:user_id] = @user.id
      redirect '/main'
    else
      flash[:error] = I18n.t(:incorrect_sign_in)
      redirect '/sign_in'
    end
  end

  get '/sign_out' do
    session_end!
    redirect '/main'
  end

  get '/sign_up' do
    if session?
      redirect '/main'
    else
      erb :sign_up
    end
  end

  post '/sign_up' do
    @user = User.new(name: params[:name], email: params[:email], password: params[:password])
    if @user.valid?
      @user.save
      session_start!
      session[:user_id] = @user.id
      redirect '/main'
    else
      flash[:error] = I18n.t(:incorrect_sign_up)
      redirect '/sign_up'
    end
  end
end
