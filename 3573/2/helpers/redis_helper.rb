require 'redis'

module RedisHelper
  def redis
    @redis ||= Redis.new
  end

  def user_id_telegram
    @user_id_telegram ||= payload['from']['id']
  end

  def user_registered?
    redis.get(user_id_telegram)
  end

  def user_number_registered?(student_number)
    redis.get(student_number)
  end

  def register_student(student_number)
    redis.set(user_id_telegram, student_number)
    redis.set(student_number, true)
  end
end
