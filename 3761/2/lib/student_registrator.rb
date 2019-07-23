Dir[File.join('.', 'helper', '*.rb')].each { |file| require file }

class StudentRegistrator
  include Helper
  include MessageRespond

  FILE_NAME = './data/student.txt'.freeze

  attr_reader :student_number, :telegram_id

  def initialize(student_number, telegram_id)
    @student_number = student_number
    @telegram_id = telegram_id
  end

  def self.call(student_number, telegram_id)
    new(student_number, telegram_id).call
  end

  def call
    response = I18n.t(:start_wrong_number)
    return { status: false, message: response } unless student_list.include?(student_number)

    response = I18n.t(:start_student_exist)
    return { status: false, message: response } if student_registered?(student_number)

    registration
  end

  private

  def registration
    redis_registration(telegram_id, student_number)
    { status: true, message: I18n.t(:start_end) } if redis.get(telegram_id)
  end

  def student_list
    File.open(FILE_NAME, 'r', &:read).split(' ')
  end
end
