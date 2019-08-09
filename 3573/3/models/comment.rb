require 'sinatra'
require 'sinatra/activerecord'

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :place

  validates :text, :star, :user, :place, presence: true
end
