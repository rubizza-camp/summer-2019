class User < ActiveRecord::Base
  attribute :name
  attribute :email
  attribute :password
  has_many :reviews

  def self.create_user(email, name, password)
    User.create(name: name, email: email,
                password: BCrypt::Password.create(password))
  end
end
