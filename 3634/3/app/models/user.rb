# :reek:InstanceVariableAssumption
class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email,    presence: true,
                       uniqueness: true,
                       format: { with: /\w+@\w+\.\w+/ }

  has_secure_password
  has_many :comments
end
