class User < ActiveRecord::Base
  has_many :comments, dependent: :destroy
end
