Dir[File.join('.', 'helpers', '*.rb')].each { |file| require file }

class StudentRegistrator
  include Helper

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
    raise Errors::InvalidNumberError unless student_list.include?(student_number)

    raise Errors::StudentAlreadyExistError if student_registered?(student_number)

    register
  end

  private

  def register
    register_with_redis(telegram_id, student_number)
  end

  def student_list
    File.open(FILE_NAME, 'r', &:read).split(' ')
  end
end
