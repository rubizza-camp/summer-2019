class Post < ActiveRecord::Base
  has_many :reviews

  def calculate
    reviews.average(:star)
  end

end
