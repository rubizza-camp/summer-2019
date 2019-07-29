# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'

# users comments model
class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :place

  validates :text, :star, :user, :place, presence: true
end
