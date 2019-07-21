require_relative 'telegram_get_from_api'
require_relative 'module/recieve_user_data'
require_relative 'geolocation_controller'
require_relative 'str_container'
require_relative 'file_controller'
require 'date'
require 'fileutils'
require 'time'

class UserSession
  include RecieveUserData
  attr_reader :session_data, :session_course_index, :user_sessions, :bot_token

  def initialize(user_sessions, bot_webhook, bot_token)
    @bot_token = bot_token
    @session_controller = user_sessions
    @session_course_index = 0
    @session_data = {}
    request_next_operation(bot_webhook)
  end

  def request_next_operation(bot_webhook)
    request_checkin_operation(bot_webhook)
    request_checkout_operation(bot_webhook)
  end

  def request_checkin_operation(bot_webhook)
    request_user_pic(bot_webhook) if @session_course_index.zero?
    request_user_geo(bot_webhook) if @session_course_index == 1
    complete_user_checkin(bot_webhook) if @session_course_index == 2
  end

  def request_checkout_operation(bot_webhook)
    request_user_pic(bot_webhook) if @session_course_index == 3
    request_user_geo(bot_webhook) if @session_course_index == 4
    complete_user_checkout(bot_webhook) if @session_course_index == 5
  end

  def receive_current_operation(bot_webhook)
    return recieve_user_photo_in(bot_webhook) if @session_course_index.zero?
    return recieve_user_geo_in(bot_webhook) if @session_course_index == 1
    return recieve_user_photo_out(bot_webhook) if @session_course_index == 3
    return recieve_user_geo_out(bot_webhook) if @session_course_index == 4
  end

  def closed?
    @session_data[:check_out_date]
  end

  def ready_to_close?
    @session_course_index == 2
  end

  def close(bot_webhook)
    @session_course_index += 1
    request_next_operation(bot_webhook)
  end

  def generate_check_files(pos)
    FileController.move_user_tmp_photo(pos,
                                       @session_controller.user_sessions[:user_name], @session_data)
    FileController.create_user_geo_txt(pos,
                                       @session_controller.user_sessions[:user_name], @session_data)
  end

  private

  # Send to user request
  def request_user_pic(bot_webhook)
    message = StrContainer.send_yourself_pic
    @session_controller.class.send_message(message, bot_webhook)
  end

  def request_user_geo(bot_webhook)
    message = StrContainer.truly_here
    @session_controller.class.send_message(message, bot_webhook)
  end

  def complete_user_checkin(bot_webhook)
    message = StrContainer.god_luck + StrContainer.check_out_help
    @session_controller.class.send_message(message, bot_webhook)
    @session_data[:check_in_date] = Time.now
    generate_check_files('in')
  end

  def complete_user_checkout(bot_webhook)
    message = StrContainer.good_rest
    @session_controller.class.send_message(message, bot_webhook)
    @session_data[:check_out_date] = Time.now
    generate_check_files('out')
  end
end
