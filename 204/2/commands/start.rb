require_relative 'status.rb'
require_relative 'bot_response.rb'

class Start
  attr_reader :status

  def initialize(status)
    @status = status
  end

  # :reek:all
  def call(options, response)
    case status.current
    when Status::WAITING.inspect
      status.set(Status::PENDING_CHECKIN_PHOTO)
      response.message('Вводи /checkin и погнали отмечаться!', options)
    when nil
      status.set(Status::WAITING)
      response.message('Введи свой порядковый номер!', options)
    else
      response.message('Ошибочка вышла! Попробуй снова', options)
    end
  end
end
