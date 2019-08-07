# :reek:InstanceVariableAssumption
class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email,    presence: true,
                       uniqueness: true,
                       format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }

  has_secure_password
  has_many :comments
end
