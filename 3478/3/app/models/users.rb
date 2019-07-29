# frozen_string_literal: true

class User < ActiveRecord::Base
  has_many :comments, dependent: :destroy
end
