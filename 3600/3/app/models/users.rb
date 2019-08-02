# frozen_string_literal: true

class User < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  validates :name, :email, :password, presence: true, uniqueness: true
end
