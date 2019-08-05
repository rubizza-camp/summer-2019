require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'

class Comment < ActiveRecord::Base
  validates :score, presence: { message: 'Поставьте оценку' }
  validates :text, presence: { message: 'Напишите отзыв' }, if: :too_low_score
  belongs_to :user
  belongs_to :restaurant

  def too_low_score
    score ? score < 3 : false
  end
end
