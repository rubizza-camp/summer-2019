class Place < ActiveRecord::Base
  validates :name, presence: true
  has_many :comments

  def average
    comments.average(:rating)
  end
end
