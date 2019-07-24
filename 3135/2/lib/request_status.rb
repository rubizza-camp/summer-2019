require_relative 'db'

# RequestStatus class manages current requests and stores their statuses to redis
class RequestStatus
  attr_reader :key

  def initialize(tg_id)
    @key = "tgid_#{tg_id}_request"
  end

  def what?
    DB.redis.get(key)
  end

  def flush
    DB.redis.del(key)
  end

  # -campnum
  def camp_num
    DB.redis.set(key, 'camp_num')
  end

  def camp_num?
    DB.redis.get(key) == 'camp_num'
  end

  # -photo
  def photo
    DB.redis.set(key, 'photo')
  end

  def photo?
    DB.redis.get(key) == 'photo'
  end

  # -location
  def location
    DB.redis.set(key, 'location')
  end

  def location?
    DB.redis.get(key) == 'location'
  end
end

# DataSaver class saves data to redis with respect to user tg_id
class DataSaver
  attr_reader :id

  def initialize(tg_id)
    @id = tg_id
  end

  # -camp number
  def camp_num(digits)
    DB.redis.set("tgid_#{id}_camp_num", digits)
  end

  # -photo uri
  def photo_uri(uri)
    DB.redis.set("tgid_#{id}_photo_uri", uri)
  end

  # -location
  def location(coords)
    DB.redis.set("tgid_#{id}_location", coords)
  end
end
