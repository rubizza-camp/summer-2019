class Place < ActiveRecord::Base
  attribute :name
  attribute :description
  attribute :image_path
  has_many :reviews

  def self.update_place_by_id(id)
    Place.find(id).update(average_rating:
                                  RatingService.calculate_average_rating(id))
  end
end
