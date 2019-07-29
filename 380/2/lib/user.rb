class User
  def self.find(tg_id)
    new(tg_id)
  end

  attr_reader :camp_id, :tg_id, :status

  def initialize(tg_id, camp_id = nil)
    @tg_id = tg_id
    if camp_id
      @camp_id = camp_id
      Redis.current.set("user:#{tg_id}:camp_id", camp_id)
    else
      @camp_id = Redis.current.get("user:#{tg_id}:camp_id")
      @status = Redis.current.get("user:#{tg_id}:status")
    end
  end

  def save_status(status)
    Redis.current.set("user:#{tg_id}:status", status.to_sym)
  end
end
