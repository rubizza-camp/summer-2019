class User
  def self.find(tg_id)
    camp_id = Redis.current.get(tg_id)
    puts "self.find(#{tg_id})"
    puts "Redis.current.get(tg_id) #{camp_id}"
    puts "Redis.current.get(camp_id) #{Redis.current.get(camp_id)}"
    user = new(tg_id, camp_id)
    user
  end

  def self.create(tg_id, camp_id)
    user = new(tg_id, camp_id)
    Redis.current.set(tg_id, camp_id)
    user
  end

  attr_reader :camp_id, :tg_id

  def status
    Redis.current.get(camp_id)
  end

  def initialize(tg_id, camp_id = nil)
    @camp_id = camp_id
    @tg_id = tg_id
  end

  def save_status(status)
    Redis.current.set(camp_id, status.to_sym)
  end
end
