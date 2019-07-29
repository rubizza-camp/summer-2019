class UsersController < ApplicationController
  show_signup = lambda do
    erb :'auth/sign_up'
  end

  do_signup = lambda do
    params.delete 'submit'
    params[:email].downcase!
    @user = User.create(params)
    if @user.save
      flash[:success] = 'Successfully registered'
      redirect '/'
    else
      flash[:error] = "#{@user.errors.messages.keys[0]} #{@user.errors.messages.values[0][0]}"
      redirect '/sign_up'
    end
  end
  get '/sign_up', &show_signup
  post '/sign_up', &do_signup
end
