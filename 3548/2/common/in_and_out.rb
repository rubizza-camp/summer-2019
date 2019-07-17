# support checkin and checkout
module InAndOut
  def work_out(redis, check, id)
    checkin = redis.get(check).to_i
    if redis.get(id) != nil and checkin == 111
      respond_with :message, text: 'Пришли мне себяшку:'
      redis.set(check, 0)
    elsif checkin != 111
      respond_with :message, text: 'if you want to take a shift, write /checkin'
    else
      respond_with :message, text: 'you are not logged in'
    end
  end

  def work_in(redis, check, id)
    checkin = redis.get(check).to_i
    if redis.get(id) != nil and checkin < 1
      respond_with :message, text: 'Пришли мне себяшку:'
      redis.set(check, 1)
    elsif checkin != 0
      respond_with :message, text: 'if you want to pass the shift, write /checkout'
    else
      respond_with :message, text: 'you are not logged in'
    end
  end
end
