# User class provides access to user info and manages immediate properties
class User
  attr_reader :id, :camp_num, :action, :request

  def initialize(tg_id)
    @id = tg_id
    @camp_num = R.get("tgid_#{tg_id}_camp_num")
    @location = R.get("tgid_#{tg_id}_location")
    @photo_uri = R.get("tgid_#{tg_id}_photo_uri")

    @action = ActionStatus.new(tg_id)
    @request = RequestStatus.new(tg_id)
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

  # -status flush
  def status_flush
    @action.flush
    @request.flush
  end
end
