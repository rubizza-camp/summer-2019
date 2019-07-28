class AuthHelper
  def self.chek_user_email(email)
    User.where(['email = ?', email]).first
  end

  def self.check_valid_user_password(password, email)
    user = User.where(['email = ?', email]).first
    BCrypt::Password.new(user[:password]) == password
  end
end
