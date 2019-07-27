# rubocop:disable Lint/UselessAssignment
class Database
  def self.redis
    redis ||= Redis.new
  end
end
# rubocop:enable Lint/UselessAssignment
