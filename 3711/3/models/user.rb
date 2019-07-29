class User < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  validates_presence_of :username, :pass_hash, :first_name, :last_name
end
