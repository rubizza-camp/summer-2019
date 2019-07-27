class User < ActiveRecord::Base
  validates_uniqueness_of :login
  validates_uniqueness_of :email
  validates_presence_of :login
  validates_presence_of :email
  has_many :reviews
end
