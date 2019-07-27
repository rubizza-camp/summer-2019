class Database
  def self.redis
    redis ||= Redis.new
  end
end