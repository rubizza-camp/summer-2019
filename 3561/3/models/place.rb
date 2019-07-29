# frozen_string_literal: true

# place for comments
class Place < ActiveRecord::Base
  has_many :comments

  validates :name, presence: true
end
