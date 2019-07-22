class CampNumbers
  attr_reader :camp_number, :context

  def initialize(camp_number, context)
    @camp_number = camp_number
    @context = context
  end

  def valid_camp_number
    number_presence && number_is_not_in_use
  end

  def number_presence
    File.open('data/camp_numbers.txt').each do |file_number|
      return true if camp_number == file_number.gsub(/[^0-9]/, '')
    end
    false
  end

  def number_is_in_use
    context.chat_session.values.each { |user| return true if user['camp_number'] == camp_number }
    false
  end

  def number_is_not_in_use
    !number_is_in_use
  end
end
