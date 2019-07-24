require 'redis'

module RedisHelper
  def redis
    @redis ||= Redis.current
  end

  def save_session(param, message)
    redis.hmset(message.chat.id, param, message.text)
  end

  def save_photo(message)
    redis.hmset(message.chat.id, "selfie", message.last.file_id)
  end

  def checkin_session(message)
    redis.hmset(
      message.chat.id,
      "latitude",
      message.location.latitude,
      "longitude",
      message.location.longitude,
    )
    redis.hgetall(message.chat.id)
  end

  def checkout_session(message)
    redis.hdel(message.chat.id, "check_ined")
    redis.hmget(message.chat.id, "camp_id")[0]
  end

  def started?(message)
    !redis.hexists(message.chat.id, "camp_id") and message.text == '/start'
  end

  def entered?(message)
    rubizzians = ['3751', '204', '211', '13', '380', '3135', '3172']
    !redis.hexists(message.chat.id, "camp_id") and rubizzians.include?(message.text)
  end

  def camp_user?(message)
    redis.hexists(message.chat.id, "camp_id")
  end

  def check_in?(message)
    !redis.hexists(message.chat.id, "check_ined") and message.text == '/check_in'
  end

  def check_out?(message)
    redis.hexists(message.chat.id, "check_ined") and message.text == '/check_out'
  end

  def send_photo?(message)
    redis.hexists(message.chat.id, "check_ined") and message.photo.last
  end

  def send_location?(message)
    redis.hexists(message.chat.id, "check_ined") and message.location.latitude
  end
end
