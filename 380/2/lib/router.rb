module Router
  def self.resolve(message, user)
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
      operation_by_user_status(message, user)
    end
  end

  def self.operation_by_user_status(message, user)
    case user.status
    when :waiting_number
      Register.new(message.from.id).call(message.text.to_i)
    when :waiting_selfie
      Selfie.new
    when :waiting_geo
      Geo.new
    end
  end
end
