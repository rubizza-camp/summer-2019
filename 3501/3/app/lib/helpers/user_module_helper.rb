module Helpers
  module UsersAdditionalHelper
    def sign_in_user(post)
      user = find_by_email(post.params[:email])
      check_bcrypt_password(post, user)
    end

    def sign_up_user(post)
      post.session[:user_id] = try_create_user(post).id
      raise(UserEmailOccupiedError, 'Почтовый адрес уже привязан!') unless post.session[:user_id]
    end

    private

    def check_password_confirmation(post)
      raise(UserPasswordNotMatchError, 'Пароль не совпадает!') unless password_same?(post.params)
    end

    def password_same?(params)
      params[:password] == params[:password_confirmation]
    end

    def check_bcrypt_password(post, user)
      return user if user && BCrypt::Password.new(user[:password]) == post.params[:password]

      raise(UserWrongPasswordOrEmailError, 'Неверная почта либо пароль!')
    end

    # :reek:FeatureEnvy
    def try_create_user(post)
      check_password_confirmation(post)
      User.create(
        first_name: post.params[:first_name],
        last_name: post.params[:last_name],
        email: post.params[:email],
        password: BCrypt::Password.create(post.params[:password]).to_s
      )
    end

    def update_snackbar_commnets_count_and_rait(current_snack_bar, current_comments_count, post)
      current_comments_count = current_comments_count ? current_comments_count + 1 : 1
      current_snack_bar.update_attribute(:comments_count, current_comments_count)
      update_snackbar_modular_rating(current_snack_bar, current_comments_count, post)
    end

    def update_snackbar_modular_rating(current_snack_bar, current_comments_count, post)
      olt_rating = current_snack_bar.modular_rating ? current_snack_bar.modular_rating.to_f : 0.0
      new_rating = (post.params[:rating].to_f + olt_rating *
        (current_comments_count - 1)) / current_comments_count
      current_snack_bar.update_attribute(:modular_rating, new_rating)
    end
  end
end
