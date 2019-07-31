# :reek:all

class Account < ActiveRecord::Base
  include BCrypt

  has_many :reviews

  validates_presence_of :email, uniqueness: true
  validates_presence_of :name, uniqueness: true
  validates_presence_of :password

  def self.find(params_email)
    all.find_by(email: params_email)
  end

  def hash_password(password)
    BCrypt::Password.create(password).to_s
  end
end
