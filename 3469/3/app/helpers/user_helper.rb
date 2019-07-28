# frozen_string_literal: true
require 'bcrypt'
require 'email_address'
module UserHelper
  include BCrypt

  def create_user
    @user = User.new
    @user.name = params[:username]
    @user.email = params[:email]
    @user.password = params[:password]
    @user.save!
  end

  def sign_up
    already_registered if find_user_in_db
    invalid_email unless valid_email?
    password_should_be_the_same unless password_and_confirm_password?
    create_user
    session[:user_id] = @user.id
  end
  def logout
    session[:user_id] = nil
  end
  def login
    logout if login?
    no_email_in_db unless find_user_in_db
    invalid_password unless right_password?
    session[:user_id] = @user.id
  end

  def password_and_confirm_password?
    params[:password] == params[:confirm_password]
  end

  def find_user_in_db
    @user = User.find_by(email: params[:email])
  end

  def right_password?
    Password.new(@user.password_hash) == params[:password]
  end

  def valid_email?
    EmailAddress.valid?(params[:email])
  end

  def login?
    session[:user_id]
  end


end
