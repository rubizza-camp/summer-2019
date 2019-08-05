require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'

class Comment < ActiveRecord::Base
  validates :raiting, presence: { message: 'Поставьте оценку' }
  validates :text, presence: { message: 'Напишите отзыв' }, if: :too_low_raiting
  belongs_to :user
  belongs_to :restaurant

  def too_low_raiting
    raiting ? raiting < 3 : false
  end
end
