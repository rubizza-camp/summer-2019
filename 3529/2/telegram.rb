require 'telegram/bot'
require 'yaml'

class WebhooksController < Telegram::Bot::UpdatesController

  def start!(*)
    respond_with :message, text: 'Hello, rook! Enter your camp number'
  end

  def message(message)
    file = YAML.safe_load(File.read('Data/camp_participants.yaml'))
    resp = ""
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
end

TOKEN = '919190207:AAFfJhW2frNEWYeaSAvxhgwC6I233JVnVBg'
bot = Telegram::Bot::Client.new(TOKEN)

# poller-mode
require 'logger'
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start

# OR
# rack-app for webhook mode. See https://rack.github.io/ for details.
# Make sure to run `set_webhook` passing valid url.
puts 'Hello'
puts Telegram::Bot::Client::ApiHelper.define_helpers(:getFile).inspect#(file_id: 'AgADAgADuqwxG-XUmEn_C8NMsB4Nyvfetw8ABCsG3PU6ShPSR08BAAEC')
map "/#{TOKEN}" do
  run Telegram::Bot::Middleware.new(bot, WebhooksController)
end
