class SessionsController < BaseController
  # rubocop:disable Metrics/BlockLength
  namespace '/sessions' do
    get '/signup' do
      erb :'/sessions/signup'
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
        redirect '/signup'
      end
    end

    get '/login' do
      erb :'sessions/login'
    end

    post '/login' do
      @user = User.find_by(email: params[:email])
      if @user && (@user.password == params[:password])
        session[:user_id] = @user.id
        flash[:notice] = 'You logged in sucessfuly'
        redirect '/'
      else
        flash[:error] = 'Something went wrong'
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
