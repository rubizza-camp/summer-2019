class Location < ActiveRecord::Base
  has_many :commentaries
end

class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  validates :email, presence: true
  has_many :commentaries
end

class Commentary < ActiveRecord::Base
  belongs_to :user
  belongs_to :location
  validates :text, presence: { message: 'Explain low grade' }, if: :low_points
  validates :points, presence: true

  def low_points
    points < 3
  end
end
