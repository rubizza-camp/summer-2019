# frozen_string_literal: true

class User < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  validates :name, :email, :password, presence: true, uniqueness: true
  validate :valid_email?

  def valid_email?
    errors.add(:email, 'wrong e-mail') unless Truemail.valid?(email)
  end
end
