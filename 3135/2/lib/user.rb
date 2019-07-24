require_relative 'action_status'
require_relative 'request_status'
require_relative 'db'

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
