# frozen_string_literal: true

class Place < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  validates_presence_of :name, :lat, :lon

  def average_stars
    reviews.average(:stars)
  end
end
