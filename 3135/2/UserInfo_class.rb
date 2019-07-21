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
    
end

#=============1act

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

#=============2req

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
end