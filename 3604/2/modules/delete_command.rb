require_relative 'responses_helper.rb'

module DeleteCommand
  include ResponsesHelper

  def remove_account!(*)
    return respond_with :message, text: USER_ARE_NOT_REGISTERED_RESPONSE unless user_registered?
    remove_from_redis
    respond_with :message, text: user_name.to_s + REMOVE_ACCOUNT_RESPONSE
  end

  private

  def remove_from_redis
    number = redis.get(user_id_telegram)
    redis.del(number)
    redis.del(user_id_telegram)
  end
end
