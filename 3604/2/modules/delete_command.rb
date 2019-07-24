module DeleteCommand
  def remove_account!(*)
    return respond_with :message, text: I18n.t(:not_registered_response) unless user_registered?
    remove_from_redis
    respond_with :message, text: user_name.to_s + I18n.t(:remove_account_response)
  end

  private

  def remove_from_redis
    number = redis.get(user_id_telegram)
    redis.del(number)
    redis.del(user_id_telegram)
  end
end
