module Settings
  def self.token
    @token ||= ENV['TELEGRAM_BOT_TOKEN']
  end
end
