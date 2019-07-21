# User class provides access to user info and manages immediate properties
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
    R.get("tgid_#{@id}_rank") == 'resident'
  end

  def give_residency
    R.set("tgid_#{@id}_rank", 'resident')
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
  def photo_uri(uri)
    R.get("tgid_#{@id}_photo_uri")
  end

  # -location
  def location(lat_as_str,long_as_str)
    R.get("tgid_#{@id}_location")
  end
end
