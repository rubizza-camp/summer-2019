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

  def call
    case message.text
    when '/start'    then start
    when /^\d+$/     then digits
    when '/checkin'  then checkin
    when '/checkout' then checkout
    when '/stop'     then stop
    else other_input
    end
  end

  # rubocop:disable Style/EmptyCaseCondition
  def other_input
    case
    when message.photo.any? then photo
    when message.location   then location
    else
      unexpected('main switch')
    end
  end
  # rubocop:enable Style/EmptyCaseCondition

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

  # rubocop:disable Metrics/AbcSize
  def digits
    return unexpected(__method__) unless user.action.registration? && user.request.camp_num?

    digits = message.text
    if !Utils.recruit_list.include?(digits)
      'Sorry, you are not on the list of rubizza recruits.'
    elsif Utils.registered_list.include?(digits)
      'Sorry, the recruit with this number is already registered.'
    else
      Registration.camp_num(user, digits)
    end
  end
  # rubocop:enable Metrics/AbcSize

  def checkin
    return unexpected(__method__) unless user.resident? && !user.present?

    Reception.checkin(user)
  end

  def checkout
    return unexpected(__method__) unless user.resident? && user.present?

    Reception.checkout(user)
  end

  def photo
    return unexpected(__method__) unless user.request.photo?

    Reception.photo(user, Utils.construct_photo_uri(message.photo, bot))
  end

  def location
    return unexpected(__method__) unless user.request.location?

    Reception.location(user, Utils.construct_location(message.location))
  end

  def unexpected(where_from = nil)
    "unexpected input (#{where_from})"
  end
end
