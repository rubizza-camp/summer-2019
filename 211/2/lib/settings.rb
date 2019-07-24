module Settings
  def self.redis
    @redis ||= Redis.new
  end

  def self.token
    @token ||= ENV['TELEGRAM_BOT_TOKEN']
  end
end
