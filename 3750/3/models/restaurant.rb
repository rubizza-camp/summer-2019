class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  validates_presence_of :name, :latitude, :longitude

  def average_grade
    reviews.average(:grade)
  end
end
