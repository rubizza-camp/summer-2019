require 'telegram/bot'
require 'redis'
require 'down'
require 'fileutils'
require 'yaml'
require 'pry'
require 'open-uri'
require_relative 'commands/register.rb'
require_relative 'commands/start.rb'
require_relative 'commands/check.rb'
require_relative 'commands/geolocation.rb'
require_relative 'commands/photo.rb'
require_relative 'commands/status.rb'
require_relative 'commands/redis_helper.rb'
require_relative 'commands/bot_response.rb'

class TelegramBot
  attr_reader :response, :status

  def initialize
    @response = BotResponse.new
  end

  def parse_yaml
    YAML.load_file('users.yaml')
  end

  # :reek:all
  def run(token, redis)
    Telegram::Bot::Client.run(token) do |bot|
      bot.listen do |message|
        options = { bot: bot, redis: redis, message: message, chat_id: message.chat.id }
        users = parse_yaml
        @status = RedisHelper.new(options)
        flow(token, users, options)
      end
    end
  end

  def start_new_cycle
    status.set(Status::PENDING_CHECKIN_PHOTO) if
    status.current == Status::FINISH_REGISTRATION
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def flow(token, users, options)
    case options[:message].text
    when '/start'
      Start.new(status).call(options, response)
    when '/checkin'
      start_new_cycle
      Check.new(options, status).checkin(response)
    when '/checkout'
      Check.new(options, status).checkout(response)
    when '/developer/status'
      Status.new.developer(response, status, options)
    when '/commands'
      available_commands(options)
    else
      additional_flow(token, users, options)
    end
  end

  def additional_flow(token, users, options)
    if options[:message].text.to_i.positive?
      Registration.new(users, options, status, response).call
    elsif options[:message].photo.last.respond_to?(:file_id)
      PhotoLoader.new(token, options, status, response).call
    elsif options[:message].location.nil? == false
      GeolocationFinder.new(options, status, response).call
    end
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def available_commands(options)
    commands = %w[/start /checkin /checkout]
    response.message(commands.to_s, options)
  end
end

p 'Enter your TelegramBot token'
token = gets.chomp
redis = Redis.new

TelegramBot.new.run(token, redis)
