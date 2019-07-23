require 'redis'

module RedisHelper
  def redis
    @redis ||= Redis.new
  end

  def user_id_telegram
    @user_id_telegram ||= payload['from']['id']
  end

  def user_name
    @user_name ||= payload['from']['first_name']
  end

  def user_registered?
    redis.get(user_id_telegram)
  end
end
