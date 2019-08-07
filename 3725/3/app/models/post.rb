class Post < ActiveRecord::Base
  has_many :reviews

  def calculate
    self.reviews.average(:star)
  end

end
