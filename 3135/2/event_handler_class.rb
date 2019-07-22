require_relative 'utils_module'

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
      case
      when message.photo.any?
        if user.request.photo?
          Reception.photo(user, Utils.construct_photo_uri(message, bot))
        else
          'unexpected input (photo)'
        end
      when message.location
        if user.request.location?
          Reception.location(user, Utils.construct_location(message))
        else
          'unexpected input (photo)'
        end
      else
        'wrong input main switch'
      end
    end
  end
end