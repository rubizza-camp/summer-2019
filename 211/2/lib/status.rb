module StatusChanger
  def waiting_for_photo(message)
    new_status = 'checkins' if message == '/checkin'
    new_status = 'checkouts' if message == '/checkout'
    REDIS.set("#{user_id}_status", new_status)
    REDIS.set("#{user_id}_state", 'waiting for photo')
  end

  def waiting_for_location
    REDIS.set("#{user_id}_state", 'waiting for location')
  end

  def final_status(status)
    new_status = 'checkined' if status == 'checkins'
    new_status = 'checkouted' if status == 'checkouts'
    REDIS.set("#{user_id}_status", new_status)
    REDIS.set("#{user_id}_state", new_status)
  end

  def start
    REDIS.set("#{user_id}_status", 'started')
  end
end
