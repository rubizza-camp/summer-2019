module Router
  def self.resolve(message)
    puts "User.find(message.from.id) #{User.find(message.from.id)}"
    puts "'/start'? #{message.text}"
    case message.text
    when '/start'
      Start.new(message.from.id).call
    when '/check_in'
      CheckIn.new(message.from.id).call
    when '/check_out'
      CheckOut.new
    when '/help'
      Help.new
    else
      operation_by_user_status(message)
    end
  end

  def self.operation_by_user_status(message)
    user = User.find(message.from.id)
    puts "message #{message.text} status #{user.status}"
    case user.status
    when :waiting_for_number
      Register.new(message.from.id).call(message.text.to_i)
    when :waiting_for_selfie
      Selfie.new
    when :waiting_for_geo
      Geo.new
    end
  end
end
