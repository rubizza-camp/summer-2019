require 'redis'
require_relative 'numbers'

module StartCommand
  def start!(*)
    if session.key?(:number)
      respond_with :message, text: "You already have a number #{session[:number]}"
    else
      save_context :registration
      respond_with :message, text: 'Enter your number'
    end
  end

  def registration(number)
    redis = Redis.new

    if Numbers.valid_number?(number.to_i)
      session[:number] = number
      redis.set(number, payload['from']['id'])
      respond_with :message, text: 'Successful registration'
    else
      respond_with :message, text: 'Wrong number'
    end
  end
end
