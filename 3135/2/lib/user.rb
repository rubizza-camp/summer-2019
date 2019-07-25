require_relative 'action_status'
require_relative 'request_status'
require_relative 'db'

# User class provides access to user info and manages immediate properties
#:reek:TooManyInstanceVariables
#:reek:DuplicateMethodCall
class User
  attr_reader :id, :action, :request

  def initialize(tg_id)
    @id = tg_id

    @action = ActionStatus.new(tg_id)
    @request = RequestStatus.new(tg_id)
  end

  def key(name)
    "tgid_#{id}_#{name}"
  end

  # -residency
  def resident?
    DB.get("tgid_#{id}_rank") == 'resident'
  end

  def give_residency
    DB.set("tgid_#{id}_rank", 'resident')
  end

  # -presence
  def presence_init
    DB.set("tgid_#{id}_presence", 'offsite')
  end

  def present?
    DB.get("tgid_#{id}_presence") == 'onsite'
  end

  def presence_switch
    if present?
      DB.set("tgid_#{id}_presence", 'offsite')
    else
      DB.set("tgid_#{id}_presence", 'onsite')
    end
  end

  # -status flush
  def status_flush
    action.flush
    request.flush
  end

  # -save
  %w[camp_num photo_uri location].each do |name|
    define_method("save_#{name}") { |data| DB.set(key(name), data) }
    define_method(name.to_s) { DB.get(key(name)) }
  end
end
