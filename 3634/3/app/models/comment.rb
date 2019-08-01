class Comment < ActiveRecord::Base
  validates :mark, inclusion: { in: 1..5 }

  belongs_to :user
  belongs_to :restaurant

  def bad_mark?
    (1..3).cover? mark
  end

  def empty?
    annotation.empty?
  end
end
