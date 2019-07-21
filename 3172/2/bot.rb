require 'telegram/bot'
require 'yaml'
require 'redis'
require 'json'
require 'open-uri'
require 'fileutils'

TOKEN = '839245120:AAFNkeNCKJTSOkDnx3q9yO94jWOH-bXOTpA'

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    chat_id = message.chat.id
    case message.text
    when '/start'
      bot_answer = start(message)
    when '/checkin'
      bot_answer = checkin(chat_id)
    when '/checkout'
      bot_answer = checkout(chat_id)
    else
      bot_answer = data_input(message, bot)
    end
    bot.api.send_message(chat_id: message.chat.id, text: bot_answer)
  end
end

class ReadYaml
  def self.call(file_name)
    participants = YAML.safe_load(File.open(file_name))['participants']
  end
end

def save_session(chat_id, session_params)
  Redis.new.set(chat_id, session_params.to_json)
end

def load_session_params(chat_id)
  session_params = Redis.new.get(chat_id)
  return nil unless session_params
  JSON.parse(session_params)
end

def start(message)
  chat_id = message.chat.id
  session_params = load_session_params(chat_id)

  if session_params
    return 'You are already logged in.'
  else
    session_params = { 'state' => 'start' }
    save_session(chat_id, session_params)
    return "Hello, #{message.from.first_name}. Enter your ID."
  end
end

def verify_rubizza_id(rubizza_id)
  participants = ReadYaml.call('data')
  participants.include? rubizza_id.to_i
end

def save_rubizza_id(chat_id, rubizza_id)
  session_params = load_session_params(chat_id)
  session_params['rubizza_id'] = rubizza_id
  session_params['state'] = 'ready'
  session_params['check'] = 'checkout'
  save_session(chat_id, session_params)
end

def do_checkin(location, chat_id)
  session_params = load_session_params(chat_id)
  photo_id = session_params['photo']
  file_path = bot.api.get_file(file_id: photo_id).file_path
  photo_url = "https://api.telegram.org/file/bot#{TOKEN}/#{file_path}"
  timestamp = Time.now
  folder_path = "public/#{chat_id}/checkins/#{timestamp}/"
  FileUtils.mkdir_p folder_path
  open(photo_url) do |image|
    File.open(".#{folder_path}selfie.jpg", "wb") do |file|
      file.write(image.read)
    end
  end
  File.open("#{folder_path}text.txt", 'w') { |file| file.write(location) }
  session_params.delete('photo')
  session_params['state'] = 'ready'
  session_params['check'] = 'checkin'
  save_session(chat_id, session_params)
  "Great, you made a check in"
end

def data_input(message, bot)
  chat_id = message.chat.id
  session_params = load_session_params(chat_id)
  return 'The bot is not running. Press /start' unless session_params
  state = session_params['state']

  case state
  when 'start'
    rubizza_id = message.text
    if verify_rubizza_id(rubizza_id)
      save_rubizza_id(chat_id, rubizza_id)
      return 'Enter command /checkin or /checkout'
    else
      return 'ID is not in the list'
    end
  when 'ready'
    'Enter command /checkin or /checkout'
  when 'wait_picture'
    if message.photo.size > 0
      session_params = load_session_params(chat_id)
      session_params['state'] = 'wait_locate'
      session_params['photo'] = message.photo[0].file_id

      save_session(chat_id, session_params)
      return 'Send your locate:'
    else
      return "You didn't send a selfy"
    end
  when 'wait_locate'
    location = message.location
    if location

      do_checkin(location, chat_id)
    else
      return 'Send your locate:'
    end
  else
    return 'Error command'
  end
end

def checkin(chat_id)
  session_params = load_session_params(chat_id)
  return 'The bot is not running. Press /start' unless session_params
  return 'you have already done Checkin' if session_params['check'] == 'checkin'
  session_params['state'] = 'wait_picture'
  save_session(chat_id, session_params)
  'Send me a selfy:'
end

def checkout(chat_id)
  session_params = load_session_params(chat_id)
  return 'The bot is not running. Press /start' unless session_params
  return 'you have already done Checkout' if session_params['check'] == 'checkout'
  session_params['state'] = 'wait_picture'
  save_session(chat_id, session_params)
  'Send me a selfy:'
end
