class Restaurant < ActiveRecord::Base
  validates_uniqueness_of :name, :location, :description, :photo
  validates_presence_of :name, :location, :description, :photo

  has_many :reviews, dependent: :destroy

  def rating
  	if self.reviews.average(:mark).nil?
  	  'nobody marks us yet'
    else 
      self.reviews.average(:mark).round(2)
    end
  end

  def min_description
  	self.description.slice(0..(self.description.index("\n")))
  end

  def lat
  	self.location.split(',')[0]
  end

  def long
  	self.location.split(',')[1]
  end

end
