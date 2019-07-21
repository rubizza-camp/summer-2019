require_relative 'user_session'
require_relative 'redis_storage_controller'
require_relative 'course_controller'

class UserSessionsController
  class << self
    def send_message(message, bot_webhook)
      bot_webhook.respond_with(:message, text: message)
    end
  end
  attr_reader :user_sessions, :course, :bot_token

  def initialize(user_sessions, bot_token, bot_webhook)
    @course = CourseController.new
    @user_sessions = user_sessions
    @bot_token = bot_token
    find_user(bot_webhook)
  end

  def recieve_command(command, bot_webhook)
    return registration_commands(command, bot_webhook) if @course.current.eql?(0)
    return user_commands(command, bot_webhook) if @course.current.eql?(1)
  end

  private

  def find_user(bot_webhook)
    if @user_sessions[:user_id]
      @course.course(1)
      self.class.send_message(StrContainer.welcome_old(@user_sessions[:user_name]), bot_webhook)
    else
      @course.course(0)
      self.class.send_message(StrContainer.welcome_new, bot_webhook)
    end
  end

  # Methods for registration commands
  def registration_commands(command, bot_webhook)
    return check_user_consist(bot_webhook) if command.eql?(:message)

    self.class.send_message(StrContainer.need_number, bot_webhook)
  end

  def check_user_consist(bot_webhook)
    current_user_name = bot_webhook.payload['text'][/\d+/]
    return check_user_name_avaliable(bot_webhook, current_user_name) if
        load_registred_users.include?(current_user_name)

    self.class.send_message(StrContainer.number_not_consist, bot_webhook)
  end

  def check_user_name_avaliable(bot_webhook, current_user_name)
    if RedisStorageController.user_name_is_free?(current_user_name)
      RedisStorageController.occupy_user_name(current_user_name)
      register_new_user(bot_webhook.payload['from']['id'], current_user_name, bot_webhook)
    else
      self.class.send_message(StrContainer.busy_user_name, bot_webhook)
    end
  end

  def register_new_user(user_id, user_name, bot_webhook)
    @user_sessions[:user_name] = user_name
    @user_sessions[:user_id] = user_id
    @course.course(1)
    self.class.send_message(StrContainer.registred_new(@user_sessions[:user_name]), bot_webhook)
  end

  def load_registred_users
    avaliable_ids = []
    File.open('data', 'r').each do |line|
      avaliable_ids += line.scan(/\d+/)
    end
    avaliable_ids
  end

  # Methods for user commands
  def user_commands(command, bot_webhook)
    process_new_user_session(bot_webhook) if command.eql?(:checkin)
    return self.class.send_message(StrContainer.session_allclosed, bot_webhook) unless
      @user_sessions[:sessions]
    return self.class.send_message(StrContainer.session_allclosed, bot_webhook) if
      @user_sessions[:sessions].last.closed?

    process_opened_user_session(command, bot_webhook)
  end

  def process_new_user_session(bot_webhook)
    if @user_sessions[:sessions]
      if @user_sessions[:sessions].last.closed?
        @user_sessions[:sessions] << UserSession.new(self, bot_webhook, @bot_token)
      else
        self.class.send_message(StrContainer.session_unclosed, bot_webhook)
      end
    else
      @user_sessions[:sessions] = []
      @user_sessions[:sessions] << UserSession.new(self, bot_webhook, @bot_token)
    end
  end

  def process_opened_user_session(command, bot_webhook)
    process_old_user_session(bot_webhook) if command.eql?(:checkout)
    process_user_data_messages(bot_webhook) if command.eql?(:message)
  end

  def process_old_user_session(bot_webhook)
    if @user_sessions[:sessions].last.ready_to_close?
      @user_sessions[:sessions].last.close(bot_webhook)
    else
      self.class.send_message(StrContainer.more_data, bot_webhook)
    end
  end

  def process_user_data_messages(bot_webhook)
    @user_sessions[:sessions].last.receive_current_operation(bot_webhook)
  end
end
