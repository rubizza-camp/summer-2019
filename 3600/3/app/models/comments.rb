# frozen_string_literal: true

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant
  validates :comment, presence: true, if: :bad_review?

  def bad_review?
  grade <= 3
  end
end
