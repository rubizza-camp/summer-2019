require 'redis'

module AddMethods
  def response_if_not_registered
    respond_with :message, text: "You're not registered"
  end

  def redis
    @redis ||= Redis.new
  end

  def user_id_telegram
    @user_id_telegram ||= payload['from']['id']
  end
end
