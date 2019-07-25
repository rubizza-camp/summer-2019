# DB class is used to access redis
# rubocop:disable Lint/UselessAssignment
class DB
  def self.redis
    redis ||= Redis.new
  end

  def self.get(key)
    redis.get(key)
  end

  def self.set(key, value)
    redis.set(key, value)
  end

  def self.del(key)
    redis.del(key)
  end
end
# rubocop:enable Lint/UselessAssignment
