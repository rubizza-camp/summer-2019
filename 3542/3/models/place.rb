class Place < ActiveRecord::Base
  validates :name, :address, :description, presence: true

  has_many :comments

  def average_mark
    comments.average(:mark)
  end
end
