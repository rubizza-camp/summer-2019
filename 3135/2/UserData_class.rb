require 'redis'

class UserData
  attr_reader :id, :camp_num, :presence_status, :action_status, :request_status

  def initialize(id)
    @r = Redis.new(host: 'localhost')
    @id = id
    @camp_num = @r.get("tgid_#{@id}_camp_num")

    @presence_status = @r.get("tgid_#{@id}_presence_status")
    @action_status = @r.get("tgid_#{@id}_action_status")
    @request_status = @r.get("tgid_#{@id}_request_status")
  end

  # ===========================

  def register(num_as_str)
    @r.set("tgid_#{@id}_camp_num", num_as_str)
  end

  def resident?
    @r.exists("tgid_#{@id}_camp_num")
  end
  
  # ===========================
  
  def assign_presence_status(status)
    @r.set("tgid_#{@id}_presence_status", status)
  end

  def present?
    @r.get("tgid_#{@id}_presence_status") == 'present'
  end

  # ===========================

  def assign_action_status(status)
    @r.set("tgid_#{@id}_action_status", status) # ,{ ex: 600 }
  end

  def assign_request_status(status)
    @r.set("tgid_#{@id}_request_status", status) # ,{ ex: 600 }
  end

  def delete_action_status
    @r.del("tgid_#{@id}_action_status")
  end

  def delete_request_status
    @r.del("tgid_#{@id}_request_status")
  end

  # ========================

end