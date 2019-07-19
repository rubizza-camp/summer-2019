require 'redis'

class UserData
  attr_reader :id, :action_status, :request_status

  def initialize(id)
    @r = Redis.new(host: 'localhost')
    @id = id

    @action_status = @r.get("tgid_#{@id}_action_status")
    @request_status = @r.get("tgid_#{@id}_request_status")
  end

  def resident?
    @r.exists("tgid_#{@id}_camp_num")
  end
  
  def assign_action_status(status)
    @r.set("tgid_#{@id}_action_status", status, { ex: 60 }) # ,{ ex: 600 }
  end

  def assign_request_status(status)
    @r.set("tgid_#{@id}_request_status", status, { ex: 60 }) # ,{ ex: 600 }
  end


  #def register
    #RedisDB0.set("tgid_#{@id}")
    #RedisDB0.set("") 
  #end

end