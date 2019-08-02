require 'active_record'

class FeedBack < ActiveRecord::Base
  belongs_to :snack_bar
  belongs_to :user
end
