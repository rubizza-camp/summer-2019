class Review < ActiveRecord::Base
  belongs_to :place
  belongs_to :user
  validates_presence_of :text, :grade
  validates :grade, numericality: { only_integer: true }
  validates :grade, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end
