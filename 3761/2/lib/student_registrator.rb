require './helper/redis_helper.rb'

class StudentRegistrator
  include RedisHelper

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
    response = 'Oops, we don\'t know student with this number'
    return { status: false, message: response } unless student_list.include?(student_number)

    response = 'Stop to do it. Student with this number\'ve already registered!'
    return { status: false, message: response } if student_registered?(student_number)

    registration
  end

  private

  def registration
    redis_registration(telegram_id, student_number)
    response = 'Great!!! Now You can continue with /checkin, /checkout'
    { status: true, message: response } if redis.get(telegram_id)
  end

  def student_list
    File.open(FILE_NAME, 'r', &:read).split(' ')
  end
end
