class PasswordService
  def self.valid_user_password?(password, email)
    user = User.find_by(['email = ?', email])
    BCrypt::Password.new(user.password) == password
  end
end
