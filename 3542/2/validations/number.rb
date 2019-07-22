class Student
  attr_reader :number, :context

  def initialize(number, context)
    @number = number
    @context = context
  end

  def valid_number?
    exist? && not_used?
  end

  def exist?
    File.open('data/numbers.txt').any? { |file_number| file_number.gsub(/[^0-9]/, '') == number }
  end

  def used?
    context.chat_session.values.any? { |user| user['number'] == number }
  end

  def not_used?
    !used?
  end
end
