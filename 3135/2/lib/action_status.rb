#require_relative 'db'
require_relative 'status'

# ActionStatus class manages currently ongoing action and stores their statuses to redis
class ActionStatus < Status
  def key
    @key ||= "tgid_#{tg_id}_action"
  end

  # -registration
  def registration
    DB.set(key, 'registration')
  end

  def registration?
    DB.get(key) == 'registration'
  end

  # -checkin
  def checkin
    DB.set(key, 'checkin')
  end

  def checkin?
    DB.get(key) == 'checkin'
  end

  # -checkout
  def checkout
    DB.set(key, 'checkout')
  end

  def checkout?
    DB.get(key) == 'checkout'
  end
end
