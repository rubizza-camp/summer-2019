class UserMethods
  def self.update_user_chekout_date(id)
    User[id].update(checkout_datetime: Time.now, is_checkin: false)
  end

  def self.registered?(telegram_id)
    User[telegram_id]
  end

  def self.checkin?(telegram_id)
    User[telegram_id].is_checkin
  end
end
