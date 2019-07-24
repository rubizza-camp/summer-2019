require 'yaml'

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
    return true if number_from_file
    false
  end

  def number_from_file
    file = YAML.load_file('./data/numbers.yml')
    file['numbers'].find { |num| num == @number.to_i }
  end

  def number_is_in_use
    context.chat_session.values.each { |user| return true if user['number'] == number }
    false
  end

  def number_is_not_in_use
    !number_is_in_use
  end
end
