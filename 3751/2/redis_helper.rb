require 'redis'

# :reek:FeatureEnvy
module RedisHelper
  def redis
    @redis ||= Redis.current
  end

  def save_session(param, message)
    redis.hmset(message.chat.id, param, message.text)
  end

  def save_photo(message)
    redis.hmset(message.chat.id, 'selfie', message.last.file_id)
  end

  def checkin_session(message)
    redis.hmset(
      message.chat.id,
      'latitude',
      message.location.latitude,
      'longitude',
      message.location.longitude
    )
    redis.hgetall(message.chat.id)
  end

  def checkout_session(message)
    redis.hdel(message.chat.id, 'check_ined')
    redis.hmget(message.chat.id, 'camp_id')[0]
  end

  def camp_user?(chat_id)
    redis.hexists(chat_id, 'camp_id')
  end

  def check_in?(message)
    redis.hexists(message.chat.id, 'check_ined')
  end
end
