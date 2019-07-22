# User class provides access to user info and manages immediate properties
class User
  attr_reader :id, :camp_num, :location, :photo_uri, :action, :request, :save

  def initialize(tg_id)
    @id = tg_id
    @camp_num = R.get("tgid_#{tg_id}_camp_num")
    @location = R.get("tgid_#{tg_id}_location")
    @photo_uri = R.get("tgid_#{tg_id}_photo_uri")

    @action = ActionStatus.new(tg_id)
    @request = RequestStatus.new(tg_id)
    @save = DataSaver.new(tg_id)
  end

  # -residency
  def resident?
    R.get("tgid_#{id}_rank") == 'resident'
  end

  def give_residency
    R.set("tgid_#{id}_rank", 'resident')
  end

  # -presence
  def presence_init
    R.set("tgid_#{id}_presence", 'offsite')
  end

  def present?
    R.get("tgid_#{id}_presence") == 'onsite'
  end

  def presence_switch
    if present? 
      R.set("tgid_#{id}_presence", 'offsite')
    else
      R.set("tgid_#{id}_presence", 'onsite')
    end
  end

  # -status flush
  def status_flush
    @action.flush
    @request.flush
  end
end

# ActionStatus class manages currently ongoing action and stores their statuses to redis
class ActionStatus
  attr_reader :key

  def initialize(tg_id)
    @key = "tgid_#{tg_id}_action"
  end

  def what?
    R.get(key)
  end

  def flush
    R.del(key)
  end

  # -registration
  def registration
    R.set(key, 'registration')
  end

  def registration?
    R.get(key) == 'registration'
  end

  # -checkin
  def checkin
    R.set(key, 'checkin')
  end

  def checkin?
    R.get(key) == 'checkin'
  end

  # -checkout
  def checkout
    R.set(key, 'checkout')
  end

  def checkout?
    R.get(key) == 'checkout'
  end
end

# RequestStatus class manages current requests and stores their statuses to redis
class RequestStatus
  attr_reader :key

  def initialize(tg_id)
    @key = "tgid_#{tg_id}_request"
  end

  def what?
    R.get(key)
  end

  def flush
    R.del(key)
  end

  # -campnum
  def camp_num
    R.set(key, 'camp_num')
  end

  def camp_num?
    R.get(key) == 'camp_num'
  end

  # -photo
  def photo
    R.set(key, 'photo')
  end

  def photo?
    R.get(key) == 'photo'
  end

  # -location
  def location
    R.set(key, 'location')
  end

  def location?
    R.get(key) == 'location'
  end
end

# DataSaver class saves data to redis with respect to user tg_id
class DataSaver
  attr_reader :id

  def initialize(tg_id)
    @id = tg_id
  end

  # -camp number
  def camp_num(num_as_str)
    R.set("tgid_#{id}_camp_num", num_as_str)
  end

  # -photo uri
  def photo_uri(uri)
    R.set("tgid_#{id}_photo_uri", uri)
  end

  # -location
  def location(coords)
    R.set("tgid_#{id}_location", coords)
  end
end
