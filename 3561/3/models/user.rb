# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'

# users model
class User < ActiveRecord::Base
  include BCrypt

  has_many :comments

  validates :name, :email, :password_hash, presence: true
  validates_format_of :email, with: /@/

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
