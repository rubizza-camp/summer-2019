class User < ActiveRecord::Base
  include BCrypt

  before_save { self.email = email.downcase }

  has_many :reviews, dependent: :destroy
  validates :name, presence: true
  validates :email, uniqueness: { case_sensitive: false }, 'valid_email_2/email': true

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    self.password_hash = Password.create(new_password)
  end
end
