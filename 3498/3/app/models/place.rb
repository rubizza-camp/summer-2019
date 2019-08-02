class Place < ActiveRecord::Base
  has_many :comments

  def average
    comments.average(:rating)
  end
end
