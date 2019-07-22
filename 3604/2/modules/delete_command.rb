module DeleteCommand
  def delete!(*)
    return respond_if_are_not_registered unless redis.get(user_id_telegram)
    delete_from_redis
    respond_with :message, text: "Okey, #{from['username']}! I deleted you"
  end

  private

  def delete_from_redis
    number = redis.get(user_id_telegram)
    redis.del(number)
    redis.del(user_id_telegram)
  end
end
