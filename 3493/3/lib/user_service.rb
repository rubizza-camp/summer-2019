# :reek:NilCheck:
class UserService
  def self.chek_user_email(email)
    User.find_by(['email = ?', email])&.email
  end

  def self.valid_user_password?(password, email)
    user = User.find_by(['email = ?', email])
    BCrypt::Password.new(user.password) == password
  end
end
