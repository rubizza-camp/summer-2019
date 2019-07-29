module UserHelper
  def create_new_user(post)
    return false if User.find_by_mail(post.params[:mail])
    return false unless check_password_correct?(post)

    create_new_user_with_session(post)
    true
  rescue NoMethodError
    false
  end

  def find_user_by_token(token)
    find_by_session(token)
  end

  def sign_in_user(post)
    current_user = User.find_by_mail(post.params[:login])
    return false unless current_user
    return false unless check_password(post, current_user)

    signin_user_with_session(post, current_user)
  rescue NoMethodError
    false
  end

  private

  def check_password(post, current_user)
    current_user.password == post.params[:password]
  end

  def signin_user_with_session(post, current_user)
    user_token_random = SecureRandom.base64(124)
    expired_time = post.params[:save_user] == 'on' ? (DateTime.now + 30).to_time : nil
    generate_user_token_id(post, expired_time, user_token_random)
    current_user.update_attribute(:session, user_token_random)
  end

  def check_password_correct?(post)
    return false if post.params[:password].length <= 8
    return false if post.params[:password] != post.params[:password_confirm]

    true
  end

  # :reek:FeatureEnvy
  def create_new_user_with_session(post)
    user_token_random = SecureRandom.base64(124)
    User.create(
      first_name: post.params[:first_name],
      last_name: post.params[:last_name],
      mail: post.params[:mail],
      password: post.params[:password],
      session: user_token_random
    )
    generate_new_user_session(post, user_token_random)
  end

  def generate_new_user_session(post, user_token_random)
    expired_time = (DateTime.now + 30).to_time
    generate_user_token_id(post, expired_time, user_token_random)
  end

  def generate_user_token_id(post, expired_time, user_token_random)
    post.response.set_cookie('user_token_id',
                             value: user_token_random,
                             domain: '',
                             path: '',
                             secure: true,
                             expires: expired_time)
  end
end
