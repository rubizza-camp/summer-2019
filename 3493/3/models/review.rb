class Review < ActiveRecord::Base
  attribute :title
  attribute :description
  attribute :rating
  belongs_to :user
  belongs_to :place

  def self.create_review(**params)
    Review.create(params)
  end
end
