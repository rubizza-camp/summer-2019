class Registration
  include Helper

  attr_reader :student_number, :identity

  def initialize(student_number, identity)
    @student_number = student_number
    @identity = identity
  end

  def self.call(student_number, identity)
    new(student_number, identity).call
  end

  def call
    response = 'Don\'t know student with this number'
    return { status: false, message: response } unless student_list.include?(student_number)

    response = 'You\'re already registered!'
    return { status: false, message: response } if redis.get(student_number)

    registration
  end

  private

  def student_list
    File.open(DATA_PATH, 'r', &:read).split(' ')
  end

  def registration
    redis_registration(identity, student_number)
    response = 'You can continue with /checkin, /checkout'
    { status: true, message: response } if redis.get(identity)
  end
end
