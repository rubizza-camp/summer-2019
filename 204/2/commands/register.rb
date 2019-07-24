require_relative 'status.rb'

class Registration
  attr_reader :users, :options, :status, :response

  def initialize(users, options, status, response)
    @users = users
    @options = options
    @status = status
    @response = response
  end

  # :reek:all
  def call
    RedisHelper.new(options).user_validation(users, response) if status.current == Status::WAITING
    create_user_folder if status.current == Status::PENDING_CHECKIN_PHOTO
  end

  def create_user_folder
    FileUtils.mkdir_p "users/checkins/#{status.get_value('user_id')}"
    FileUtils.mkdir_p "users/checkouts/#{status.get_value('user_id')}"
    response.message('Вводи /checkin и погнали отмечаться!', options)
  end
end
