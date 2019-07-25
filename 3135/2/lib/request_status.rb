#require_relative 'db'
require_relative 'status'

# RequestStatus class manages current requests and stores their statuses to redis
class RequestStatus < Status
  attr_reader :key

  def key
    @key ||= "tgid_#{tg_id}_request"
  end

  # -campnum
  def camp_num
    DB.set(key, 'camp_num')
  end

  def camp_num?
    DB.get(key) == 'camp_num'
  end

  # -photo
  def photo
    DB.set(key, 'photo')
  end

  def photo?
    DB.get(key) == 'photo'
  end

  # -location
  def location
    DB.set(key, 'location')
  end

  def location?
    DB.get(key) == 'location'
  end
end
