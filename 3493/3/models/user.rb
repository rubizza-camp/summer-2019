class User < ActiveRecord::Base
  attribute :name
  attribute :email
  attribute :password
  has_many :reviews
end
