class Restaraunt < ActiveRecord::Base
  has_many :comments
  validates_presence_of :name, :coordinate

  # def average_stars
  #     @restaraunt = Restaraunt.find_by(id: session[:restaraunt_id])
  #     @restaraunt.comments.star.sum / @restaraunt.comments.count
  # end
end