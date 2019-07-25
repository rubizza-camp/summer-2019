module StateChanger
  def waiting_for_photo(command)
    folder_name = 'checkins' if command == '/checkin'
    folder_name = 'checkouts' if command == '/checkout'
    Redis.current.set("#{user_id}_folder", folder_name)
    Redis.current.set("#{user_id}_state", 'waiting for photo')
  end

  def waiting_for_location
    Redis.current.set("#{user_id}_state", 'waiting for location')
  end

  def final_state(current_folder)
    state = 'checkined' if current_folder == 'checkins'
    state = 'checkouted' if current_folder == 'checkouts'
    Redis.current.set("#{user_id}_state", state)
  end

  def start
    Redis.current.set("#{user_id}_state", 'started')
  end
end
