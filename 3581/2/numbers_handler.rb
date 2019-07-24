class NumbersHandler
  attr_reader :number, :context

  def initialize(number, context)
    @number = number
    @context = context
  end

  def valid_number
    number_presence && number_is_not_in_use
  end

  def number_presence
    File.open('./data/numbers.txt').each do |file_number|
      return true if number == file_number.gsub(/[^0-9]/, '')
    end
    false
  end

  def number_is_in_use
    context.chat_session.values.each { |user| return true if user['number'] == number }
    false
  end

  def number_is_not_in_use
    !number_is_in_use
  end
end
