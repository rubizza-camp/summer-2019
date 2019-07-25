class UsersController < ApplicationController
  def new
    @users = Users.all
  end

  def create
    @user = User.new(user_params)
  end

  def show; end

  def edit; end

  def update; end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
