class Location < ActiveRecord::Base
end

class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  validates :email, presence: true
end
