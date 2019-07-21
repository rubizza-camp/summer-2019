# ActionStatus class manages currently ongoing action and stores their statuses to redis
class ActionStatus
  def initialize(tg_id)
    @key = "tgid_#{tg_id}_action"
  end

  def what?
    R.get(@key)
  end

  def flush
    R.del(@key)
  end

  # -registration
  def registration
    R.set(@key, 'registration')
  end

  def registration?
    R.get(@key) == 'registration'
  end

  # -checkin
  def checkin
    R.set(@key, 'checkin')
  end

  def checkin?
    R.get(@key) == 'checkin'
  end

  # -checkout
  def checkout
    R.set(@key, 'checkout')
  end

  def checkout?
    R.get(@key) == 'checkout'
  end
end

# RequestStatus class manages current requests and stores their statuses to redis
class RequestStatus
  def initialize(tg_id)
    @key = "tgid_#{tg_id}_request"
  end

  def what?
    R.get(@key)
  end

  def flush
    R.del(@key)
  end

  # -campnum
  def camp_num
    R.set(@key, 'camp_num')
  end

  def camp_num?
    R.get(@key) == 'camp_num'
  end

  # -photo
  def photo
    R.set(@key, 'photo')
  end

  def photo?
    R.get(@key) == 'photo'
  end

  # -location
  def location
    R.set(@key, 'location')
  end

  def location?
    R.get(@key) == 'location'
  end
end
