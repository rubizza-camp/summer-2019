class RedisHelper
  attr_reader :options, :response

  def initialize(options)
    @options = options
  end

  def set(status)
    options[:redis].set(options[:chat_id].to_s, status)
  end

  def get_value(key)
    options[:redis].get(key)
  end

  def current
    options[:redis].get(options[:chat_id].to_s)
  end

  # rubocop: disable Metrics/AbcSize
  def user_validation(users, response)
    if users['id'].include?(options[:message].text.to_i)
      options[:redis].set('user_id', options[:message].text.to_i)
      set(Status::PENDING_CHECKIN_PHOTO)
    else
      response.message('Ты нас обмамнул. Ты не с нами', options)
    end
  end
  # rubocop: enable Metrics/AbcSize

  def timestamp
    options[:redis].set('timestamp', Time.now.to_s)
  end
end
