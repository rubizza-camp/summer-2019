require_relative 'status.rb'

class Check
  attr_reader :options, :status

  def initialize(options, status)
    @options = options
    @status = status
  end

  # :reek:all
  def checkin(response)
    status.timestamp
    case status.current
    when Status::PENDING_CHECKIN_PHOTO
      create_directory(Status::CHECKIN)
      response.message('Пришли мне себяшку!', options)
    when Status::REGISTERED
      response.message('Может ты хотел написать /checkout ?', options)
    end
  end

  def checkout(response)
    status.timestamp
    case status.current
    when Status::REGISTERED
      create_directory(Status::CHECKOUT)
      response.message('Пришли мне себяшку!', options)
      status.set(Status::PENDING_CHECKOUT_PHOTO)
    when Status::FINISH_REGISTRATION
      response.message('Может быть /checkin принцесса?', options)
    end
  end

  def create_directory(type)
    FileUtils.mkdir_p "users/#{type}/#{options[:redis].get('user_id')}/" +
                      options[:redis].get('timestamp')
  end
end
