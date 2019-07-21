class UserInfo
  attr_reader :id, :camp_num, :action, :request

  def initialize(redis, tg_id)
    @r = redis
    @id = tg_id

    @camp_num = @r.get("tgid_#{@id}_camp_num")

    @action = ActionStatus.new(@r, @id)
    @request = RequestStatus.new(@r, @id)
  end

  # -residency
  def resident?
    @r.exists("tgid_#{@id}_camp_num")
  end

  def give_residency(num_as_str)
    @r.set("tgid_#{@id}_camp_num", num_as_str)
  end

  # -presence
  def presence_init
    @r.set("tgid_#{@id}_presence", 'offsite')
  end

  def present?
    @r.get("tgid_#{@id}_presence") == 'onsite'
  end

  def presence_switch
    if present? 
      @r.set("tgid_#{@id}_presence", 'offsite')
    else
      @r.set("tgid_#{@id}_presence", 'onsite')
    end
  end

  # -photo uri
  def save_photo_uri(uri)
    @r.set("tgid_#{@id}_photo_uri", uri)
    puts @r.get("tgid_#{@id}_photo_uri")
  end

  # -location
  def save_location(lat_as_str,long_as_str)
    @r.set("tgid_#{@id}_latitude", lat_as_str)
    @r.set("tgid_#{@id}_longitude", long_as_str)
    puts @r.get("tgid_#{@id}_latitude")
    puts @r.get("tgid_#{@id}_longitude")
  end
end

# ActionStatus class stores currently ongoing action to redis
class ActionStatus
  def initialize(redis, tg_id)
    @r = redis
    @key = "tgid_#{tg_id}_action"
  end

  def what?
    @r.get(@key)
  end

  def flush
    @r.del(@key)
  end

  # -registration
  def registration
    @r.set(@key, 'registration')
  end

  def registration?
    @r.get(@key) == 'registration'
  end

  # -checkin
  def checkin
    @r.set(@key, 'checkin')
  end

  def checkin?
    @r.get(@key) == 'checkin'
  end

  # -checkout
  def checkout
    @r.set(@key, 'checkout')
  end

  def checkout?
    @r.get(@key) == 'checkout'
  end
end

# RequestStatus class stores current requested to redis
class RequestStatus
  def initialize(redis, tg_id)
    @r = redis
    @key = "tgid_#{tg_id}_request"
  end

  def what?
    @r.get(@key)
  end

  def flush
    @r.del(@key)
  end

  # -campnum
  def camp_num
    @r.set(@key, 'camp_num')
  end

  def camp_num?
    @r.get(@key) == 'camp_num'
  end

  # -photo
  def photo
    @r.set(@key, 'photo')
  end

  def photo?
    @r.get(@key) == 'photo'
  end

  # -location
  def location
    @r.set(@key, 'location')
  end

  def location?
    @r.get(@key) == 'location'
  end
end