class SessionsController < BaseController
  # rubocop:disable Metrics/BlockLength
  namespace '/sessions' do
    get '/signup' do
      if session[:user_id]
        flash[:notice] = 'You already logged in'
        redirect '/'
      else
        erb :'/sessions/signup'
      end
    end

    post '/signup' do
      @user = User.new(login: params[:login], email: params[:email],
                       password: params[:password])
      if @user.save
        session[:user_id] = @user.id
        flash[:notice] = 'You signed in sucessfuly'
        redirect '/'
      else
        flash[:error] = @user.errors.full_messages
        redirect :'/sessions/signup'
      end
    end

    get '/login' do
      if session[:user_id]
        flash[:notice] = 'You already logged in'
        redirect '/'
      else
        erb :'sessions/login'
      end
    end

    post '/login' do
      @user = User.find_by(email: params[:email]).try(:authenticate, params[:password])
      if @user
        session[:user_id] = @user.id
        flash[:notice] = 'You logged in sucessfuly'
        redirect '/'
      else
        flash[:error] = ['Something went wrong']
        redirect '/sessions/login'
      end
    end

    get '/logout' do
      flash[:notice] = 'You logged out sucessfuly'
      session.clear
      redirect '/'
    end
  end
  # rubocop:enable Metrics/BlockLength
end
