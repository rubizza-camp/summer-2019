class User < ActiveRecord::Base
  include BCrupt

  validates_uniqueness_of :username, :email
  validates_presence_of :username, :email, :password_hash

  has_many :comments, dependent: :destroy
end
