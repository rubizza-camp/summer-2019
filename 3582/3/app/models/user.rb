require 'uri'
class User < ActiveRecord::Base
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: I18n.t(:incorrect_email) }
  validates :email, uniqueness: { case_sensitive: false, message: I18n.t(:already_taken_email) }
  validates :name, presence: { message: I18n.t(:empty_name) }
  validates :name, uniqueness: { case_sensitive: false, message: I18n.t(:already_taken_name) }
  validates :password, presence: { message: I18n.t(:empty_password) }
  has_many :comments
end
