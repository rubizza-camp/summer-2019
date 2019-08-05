# frozen_string_literal: true

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant
  validates :comment, presence: true
end
