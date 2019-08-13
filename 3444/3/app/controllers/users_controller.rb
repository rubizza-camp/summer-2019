class UsersController < ApplicationController
  get '/sign_up' do
    erb :'auth/sign_up'
  end

  post '/sign_up' do
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
end
