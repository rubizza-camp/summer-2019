require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'

class Comment < ActiveRecord::Base
  validates :score, presence: { message: 'Поставьте пожалуйста балл' }
  validates :score, numericality: { only_integer: true,
                                    greater_than_or_equal_to: 1,
                                    less_than_or_equal_to: 5,
                                    message: 'Введите целое число не меньше 1 и не больше 5' }
  validates :text, presence: { message: 'Поясните, почему балл такой низкий' }, if: :to_low_score?
  belongs_to :user
  belongs_to :restaurant

  def to_low_score?
    score ? score < 3 : false
  end
end
