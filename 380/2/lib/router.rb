module Router
  def self.resolve(message, bot)
    tg_id = message.from.id
    case message.text
    when '/start' then Start.new(tg_id).call
    when '/check_in' then CheckIn.new(tg_id).call
    when '/check_out' then CheckOut.new(tg_id).call
    when '/help' then '/start for get camp_id, /check_in for check in, /check_out for check out'
    else
      operation_by_user_status(message, bot)
    end
  end

  def self.operation_by_user_status(message, bot)
    user = User.find(message.from.id)
    if user.status.to_sym == :waiting_for_number
      Register.new(message.from.id).call(message.text.to_i)
    elsif (user.status.to_s.include? 'waiting_for_selfie') && !message.photo.empty?
      file_path = bot.api.get_file(file_id: message.photo.last.file_id)
      Selfie.new(message.from.id).call(file_path)
    elsif (user.status.to_s.include? 'waiting_for_geo') && message.location
      Geo.new(message.from.id).call(message.location)
    end
  end
end
