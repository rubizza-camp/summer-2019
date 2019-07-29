require 'active_record'

class SnackBar < ActiveRecord::Base
  has_many :feed_backs
  belongs_to :user
end
