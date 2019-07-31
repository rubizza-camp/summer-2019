require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'

class Comment < ActiveRecord::Base
  validates :score, presence: { message: 'Поставьте пожалуйста балл' }
  validates :text, presence: { message: 'Поясните, почему балл такой низкий' }, if: :to_low_score?
  belongs_to :user
  belongs_to :restaurant

  def to_low_score?
    score ? score < 3 : false
  end
end
