require_relative 'utils_module'

# This is a main switch that checks input and routs events
class EventHandler
  attr_reader :user, :bot, :message

  def self.call(bot, message)
    new(bot, message).call
  end

  def initialize(bot, message)
    @bot = bot
    @message = message
    @user = User.new(message.from.id)
  end

  # this method is a disaster(
  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/MethodLength, Metrics/PerceivedComplexity
  # :reek:DuplicateMethodCall:reek:TooManyStatements:
  def call
    case message.text
    when '/start'
      if user.resident?
        'You are already registered.'
      else
        Registration.start(user)
      end
    when /^\d+$/
      if user.action.registration? && user.request.camp_num?
        Registration.camp_num(user, message.text)
      else
        'unexpected input (/^\d+$/)'
      end
    when '/checkin'
      if user.resident? && !user.present?
        Reception.checkin(user)
      else
        'unexpected input (checkin)'
      end
    when '/checkout'
      if user.resident? && user.present?
        Reception.checkout(user)
      else
        'unexpected input (checkout)'
      end
    when '/status'
      puts user.action.what?
      puts user.request.what?
      puts user.present?
      puts user.location
      puts user.photo_uri
      '/status'
    else
      if message.photo.any?
        if user.request.photo?
          Reception.photo(user, Utils.construct_photo_uri(message, bot))
        else
          'unexpected input (photo)'
        end
      elsif message.location
        if user.request.location?
          Reception.location(user, Utils.construct_location(message.location))
        else
          'unexpected input (photo)'
        end
      else
        'wrong input main switch'
      end
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/MethodLength, Metrics/PerceivedComplexity
end
