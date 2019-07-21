require 'telegram/bot'
require 'yaml'

class WebhooksController < Telegram::Bot::UpdatesController

  def start!(*)
    respond_with :message, text: 'Hello, rook! Enter your camp number'
  end

  def message(message)
    file = YAML.safe_load(File.read('Data/camp_participants.yaml'))
    resp = ""
    puts session_key
    flag = false
    file['participents'].each do |participant|
      if (message['text'] == participant.keys.first.to_s)
        if participant['telegram_id'].nil?
          resp = "You've just signed in your camp database. We are watching you!!!"
          participant['telegram_id'] = payload['from']['id']
        else
          resp = "I'm sorry, but someone already have signed in with #{message['text']} number"
        end
      end
    end
    File.open('Data/camp_participants.yaml','w') do |h| 
      h.write file.to_yaml
    end
    resp = "I'm sorry, but there isn't anyone in the camp with #{message['text']} number" if resp == ""
    respond_with :message, text: "#{resp}"
  end

  def checkin!(*)
     respond_with :message, text: "HEY"
  end

  def checkout!(*)
     respond_with :message, text: "BYE"
  end

  def session_key
    "from:#{payload["from"]["id"]}:chat:#{payload["chat"]["id"]}"
  end
end

TOKEN = '919190207:AAFfJhW2frNEWYeaSAvxhgwC6I233JVnVBg'
bot = Telegram::Bot::Client.new(TOKEN)
Telegram.bots_config = {
  default: TOKEN
}

# poller-mode
require 'logger'
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
