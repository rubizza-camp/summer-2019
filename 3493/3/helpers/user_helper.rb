class UserHelper
  def self.chek_user_email(email)
    User.find_by(['email = ?', email]).email if User.find_by(['email = ?', email])
  end

  def self.valid_user_password?(password, email)
    user = User.find_by(['email = ?', email])
    BCrypt::Password.new(user.password) == password
  end

  def self.create_user(email, name, password)
    User.create(name: name, email: email,
                password: BCrypt::Password.create(password))
  end
end
