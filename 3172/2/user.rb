# :reek:Attribute
class User
  attr_reader :id, :state, :photo, :rubizza_id
  attr_accessor :location

  def initialize(user_id)
    @id = user_id
    @state      = Redis.current.get("user_id:#{id}:state") || 'initial'
    @photo      = Redis.current.get("user_id:#{id}:photo")
    @rubizza_id = Redis.current.get("user_id:#{id}:rubizza_id")
  end

  def state=(new_state)
    Redis.current.set("user_id:#{id}:state", new_state)
    @state = new_state
  end

  def photo=(new_photo)
    Redis.current.set("user_id:#{id}:photo", new_photo)
    @photo = new_photo
  end

  def rubizza_id=(new_rubizza_id)
    Redis.current.set("user_id:#{id}:rubizza_id", new_rubizza_id)
    @rubizza_id = new_rubizza_id
  end
end
