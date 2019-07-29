class Place < ActiveRecord::Base
  validates :name, :address, :description, presence: true

  has_many :comments

  def average_mark
    comments.empty? ? 0.0 : comments.map(&:mark).sum.to_f / comments.count
  end
end
