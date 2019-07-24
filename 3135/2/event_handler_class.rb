require_relative 'event_processing_modules'
require_relative 'utils_module'
require_relative 'user_info_class_set'

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

  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity
  # rubocop:disable Style/EmptyCaseCondition, Metrics/MethodLength
  # :reek:TooManyStatements
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
    when '/stop'
      stop
    else other_input
    end
  end

  def other_input
    case
    when message.photo.any?
      photo
    when message.location
      location
    else
      unexpected('main switch')
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity
  # rubocop:enable Style/EmptyCaseCondition, Metrics/MethodLength

  private

  def start
    if user.resident?
      "You are already registered.\nUse /checkin, /checkout commands."
    else
      Registration.start(user)
    end
  end

  def stop
    user.status_flush
    'Seeya later, alligator!'
  end

  # rubocop:disable Metrics/AbcSize, MethodLength
  def digits
    digits = message.text
    if user.action.registration? && user.request.camp_num?
      if !Utils.recruit_list.include?(digits)
        'Sorry, you are not on the list of rubizza recruits.'
      elsif Utils.registered_list.include?(digits)
        'Sorry, the recruit with this number is already registered.'
      else
        Registration.camp_num(user, digits)
      end
    else
      unexpected(__method__)
    end
  end
  # rubocop:enable Metrics/AbcSize, MethodLength

  def checkin
    return unexpected(__method__) if !user.resident? && user.present?
    
    Reception.checkin(user)
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
      Reception.photo(user, Utils.construct_photo_uri(message.photo, bot))
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

  #def location
  #  return unexpected(__method__) unless user.request.location?
  #
  #  Reception.location(user, Utils.construct_location(message.location))
  #end

  def unexpected(where_from = nil)
    "unexpected input (#{where_from})"
  end
end
