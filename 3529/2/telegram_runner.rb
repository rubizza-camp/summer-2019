require 'telegram/bot'
require 'yaml'

class TelegramRunner
  attr_reader :token

  def initialize
    file_token = YAML.safe_load(File.read('Data/token.yaml'))
    @token = file_token['token']
  end

  def run
    bot = Telegram::Bot::Client.new(@token)
    Telegram.bots_config = {
      default: @token
    }
    bot
  end
end
