require 'redis'

module RedisHelper
  def redis
    @redis ||= Redis.new
  end

  def user_id_telegram
    @user_id_telegram ||= payload['from']['id']
  end

  def respond_if_are_not_registered
    respond_with :message, text: 'You are not registered'
  end
end
