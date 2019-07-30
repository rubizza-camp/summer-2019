class Restaurant < ActiveRecord::Base
  validates_uniqueness_of :name, :location, :description, :photo
  validates_presence_of :name, :location, :description, :photo

  has_many :reviews, dependent: :destroy

  def rating
    if reviews.average(:mark).nil?
      'nobody marks us yet'
    else
      reviews.average(:mark).round(2)
    end
  end

  def min_description
    description.slice(0..(description.index("\n")))
  end

  def lat
    location.split(',')[0]
  end

  def long
    location.split(',')[1]
  end
end
