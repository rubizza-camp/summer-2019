require "open-uri"
require 'fileutils'

class User

  attr_accessor :rubizza_number, :status, :user_id
  def initialize(user_id)
  	@user_id = user_id
  end

  def change_status(message)
  	case message.text
  	when '/checkin'
  		puts @status = "checkins"
    when '/checkout'
  		puts @status = "chekouts"
  	end
    RRRRedis.set("#{@user_id}_status", @status)
  	ask_selfie
  end

  def ask_selfie
  	{chat_id: @user_id, text: " selfie pls"}
  end



end


