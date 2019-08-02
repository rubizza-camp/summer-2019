# frozen_string_literal: true

# place for comments
class Place < ActiveRecord::Base
  has_many :comments

  validates :name, presence: true

  def update_rating
    update(rating: comments.average(:star).to_f)
  end
end
