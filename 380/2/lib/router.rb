module Router
  def self.resolve(message, bot)
    puts "User.find(message.from.id) #{User.find(message.from.id)}"
    puts "'/start'? #{message.text}"
    case message.text
    when '/start'
      Start.new(message.from.id).call
    when '/check_in'
      CheckIn.new(message.from.id).call
    when '/check_out'
      CheckOut.new(message.from.id).call
    when '/help'
      Help.new
    else
      operation_by_user_status(message, bot)
    end
  end

  def self.operation_by_user_status(message, bot)
    user = User.find(message.from.id)
    Register.new(message.from.id).call(message.text.to_i) if user.status == :waiting_for_number
    if (user.status.to_s.include? 'waiting_for_selfie') && !message.photo.empty?
      Selfie.new(message.from.id, bot).call(message.photo.last.file_id)
    elsif message.location && (user.status.include? 'waiting_for_geo')
      Geo.new(message.from.id, bot).call(message.location)
    end
  end
end
