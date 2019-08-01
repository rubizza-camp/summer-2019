# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'

# users model
class User < ActiveRecord::Base
  include BCrypt

  has_many :comments

  validates :name, :email, :password_hash, presence: true
  validates_format_of :email, with: /@/
  validates :email, uniqueness: { case_sensitive: false, message: I18n.t(:already_taken_email) }

  def password
    Password.new(password_hash)
  end

  def password=(new_password)
    self.password_hash = Password.create(new_password)
  end
end
