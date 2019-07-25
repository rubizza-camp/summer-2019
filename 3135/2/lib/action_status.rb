require_relative 'db'

# ActionStatus class manages currently ongoing action and stores their statuses to redis
class ActionStatus
  attr_reader :key

  def initialize(tg_id)
    @key = "tgid_#{tg_id}_action"
  end

  def value
    DB.redis.get(key)
  end

  def flush
    DB.redis.del(key)
  end

  # -registration
  def registration
    DB.redis.set(key, 'registration')
  end

  def registration?
    DB.redis.get(key) == 'registration'
  end

  # -checkin
  def checkin
    DB.redis.set(key, 'checkin')
  end

  def checkin?
    DB.redis.get(key) == 'checkin'
  end

  # -checkout
  def checkout
    DB.redis.set(key, 'checkout')
  end

  def checkout?
    DB.redis.get(key) == 'checkout'
  end
end
