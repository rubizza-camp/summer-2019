# frozen_string_literal: true

class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :place
  validates :comment, presence: true, length: { minimum: 10 }
  validates :stars, presence: true
end
