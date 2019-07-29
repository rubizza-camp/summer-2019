require 'redis'

module DeleteCommand
  def remove_account!(*)
    return respond_with :message, text: t(:not_registered) unless user_registered?

    remove_from_redis
    respond_with :message, text: t(:remove_account)
  end

  private

  def remove_from_redis
    number = redis.get(user_id_telegram)
    redis.del(number)
    redis.del(user_id_telegram)
  end
end
