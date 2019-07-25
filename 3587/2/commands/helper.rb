require 'redis'

module Helper
  def redis
    @redis ||= Redis.new
  end

  def student_number
    redis.get(payload['from']['id'])
  end

  def account_registered?
    redis.get(payload['from']['id'])
  end

  def redis_registration(telegram_id, student_number)
    redis.set(student_number, true)
    redis.set(telegram_id, student_number)
  end

  def path(status, time)
    File.join('.', 'public', student_number, status, time)
  end
end
