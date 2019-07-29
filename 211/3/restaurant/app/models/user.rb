class User < ActiveRecord::Base
  validates_uniqueness_of :login, :email
  validates_presence_of :login, :email, :password_digest
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_many :reviews, dependent: :destroy

  def password
    @password ||= BCrypt::Password.new(password_digest)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_digest = password
  end
end
