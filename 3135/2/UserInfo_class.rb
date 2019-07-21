# User class provides access to user info and manages immediate settings
class User
  attr_reader :id, :camp_num, :action, :request

  def initialize(tg_id)
    @id = tg_id
    @camp_num = R.get("tgid_#{@id}_camp_num")

    @action = ActionStatus.new(@id)
    @request = RequestStatus.new(@id)
  end

  # -residency
  def resident?
    R.exists("tgid_#{@id}_camp_num")
  end

  def give_residency(num_as_str)
    R.set("tgid_#{@id}_camp_num", num_as_str)
  end

  # -presence
  def presence_init
    R.set("tgid_#{@id}_presence", 'offsite')
  end

  def present?
    R.get("tgid_#{@id}_presence") == 'onsite'
  end

  def presence_switch
    if present? 
      R.set("tgid_#{@id}_presence", 'offsite')
    else
      R.set("tgid_#{@id}_presence", 'onsite')
    end
  end

  # -photo uri
  def save_photo_uri(uri)
    R.set("tgid_#{@id}_photo_uri", uri)
  end

  # -location
  def save_location(lat_as_str,long_as_str)
    R.set("tgid_#{@id}_latitude", lat_as_str)
    R.set("tgid_#{@id}_longitude", long_as_str)
  end
end
