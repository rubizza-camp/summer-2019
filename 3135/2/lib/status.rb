# Status class
class Status
  attr_reader :tg_id

  def initialize(tg_id)
    @tg_id = tg_id
  end

  def value
    DB.get(key)
  end

  def flush
    DB.del(key)
  end
end
