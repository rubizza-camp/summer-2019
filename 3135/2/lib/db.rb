# DB class is used to access redis
# rubocop:disable Lint/UselessAssignment
class DB
  def self.redis
    redis ||= Redis.new
  end
end
# rubocop:enable Lint/UselessAssignment
