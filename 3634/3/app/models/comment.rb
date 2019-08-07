class Comment < ActiveRecord::Base
  VALID_RATING = (1..5).freeze

  validates :mark, inclusion: { in: VALID_RATING }
  validate :relevance

  belongs_to :user
  belongs_to :restaurant

  def bad_mark?
    (1..3).cover? mark
  end

  def empty?
    body.empty?
  end

  def relevance
    errors.add(:low_mark, 'Please, tell us why this mark is so low?') if bad_mark? && empty?
  end
end
