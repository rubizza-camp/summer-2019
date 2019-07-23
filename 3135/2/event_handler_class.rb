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

  def call
    case message.text
    when '/start'
      start
    when /^\d+$/
      digits
    when '/checkin'
      checkin
    when '/checkout'
      checkout
    when '/status'
      status
    else
      case
      when message.photo.any?
        photo
      when message.location
        location
      else
        unexpected('main switch')
      end
    end
  end

  private

  def start
    if user.resident?
      'You are already registered.'
    else
      Registration.start(user)
    end
  end

  def digits
    if user.action.registration? && user.request.camp_num?
      if !Utils.recruit_list.include?(message.text)
        'Sorry, you are not on the list of rubizza recruits.'
      elsif Utils.registered_list.include?(message.text)
        'Sorry, the recruit with this number is already registered.'
      else
        puts "message.text = #{message.text.class}"
        Registration.camp_num(user, message.text)
      end
    else
      unexpected(__method__)
    end
  end

  def checkin
    if user.resident? && !user.present?
      Reception.checkin(user)
    else
      unexpected(__method__)
    end
  end

  def checkout
    if user.resident? && user.present?
      Reception.checkout(user)
    else
      unexpected(__method__)
    end
  end

  def photo
    if user.request.photo?
      Reception.photo(user, Utils.construct_photo_uri(message, bot))
    else
      unexpected(__method__)
    end
  end

  def location
    if user.request.location?
      Reception.location(user, Utils.construct_location(message.location))
    else
      unexpected(__method__)
    end
  end

  def unexpected(where_from = nil)
    "unexpected input (#{where_from})"    
  end
end
