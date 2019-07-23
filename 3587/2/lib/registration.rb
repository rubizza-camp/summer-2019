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
    return { status: false, message: NO_ON_THE_LIST } unless student_list.include?(student_number)

    return { status: false, message: REGISTERED } if redis.get(student_number)

    registration
  end

  private

  def student_list
    File.open(DATA_PATH, 'r', &:read).split(' ')
  end

  def registration
    redis_registration(identity, student_number)
    { status: true, message: SUCCESSFUL_REGISTRATION } if redis.get(identity)
  end
end
