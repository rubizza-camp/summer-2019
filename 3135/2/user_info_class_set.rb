# User class provides access to user info and manages immediate properties
#:reek:TooManyInstanceVariables
#:reek:DuplicateMethodCall
class User
  attr_reader :id, :camp_num, :location, :photo_uri, :action, :request, :save

  def initialize(tg_id)
    @id = tg_id
    @camp_num = DB.redis.get("tgid_#{tg_id}_camp_num")
    @location = DB.redis.get("tgid_#{tg_id}_location")
    @photo_uri = DB.redis.get("tgid_#{tg_id}_photo_uri")

    @action = ActionStatus.new(tg_id)
    @request = RequestStatus.new(tg_id)
    @save = DataSaver.new(tg_id)
  end

  # -residency
  def resident?
    DB.redis.get("tgid_#{id}_rank") == 'resident'
  end

  def give_residency
    DB.redis.set("tgid_#{id}_rank", 'resident')
  end

  # -presence
  def presence_init
    DB.redis.set("tgid_#{id}_presence", 'offsite')
  end

  def present?
    DB.redis.get("tgid_#{id}_presence") == 'onsite'
  end

  def presence_switch
    if present?
      DB.redis.set("tgid_#{id}_presence", 'offsite')
    else
      DB.redis.set("tgid_#{id}_presence", 'onsite')
    end
  end

  # -status flush
  def status_flush
    action.flush
    request.flush
  end
end

# ActionStatus class manages currently ongoing action and stores their statuses to redis
class ActionStatus
  attr_reader :key

  def initialize(tg_id)
    @key = "tgid_#{tg_id}_action"
  end

  def what?
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
