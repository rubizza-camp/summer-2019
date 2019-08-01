class Place < ActiveRecord::Base
  validates :name, :location, :description, :rating, presence: true

  has_many :comments

  def self.update_rating(place)
    place.update(rating: place.comments.average(:rating))
  end
end
